//
//  MGOpenALSupport.c
//  MyGame
//
//  Created by Marina Osés Merino on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#include "MGOpenALSupport.h"
#include <stdio.h>
#include <stddef.h> //NULL


ALvoid alBufferDataStatic(ALint buffer_id, ALenum al_format, ALvoid *pcm_data, ALsizei buffer_size, ALsizei sample_rate) {
    static alBufferDataStaticProcPtr the_proc = NULL;
    
    if (the_proc == NULL) {
        the_proc = (alBufferDataStaticProcPtr) alGetProcAddress((ALchar *)"alBufferDataStatic");
    }
    
    if (the_proc != NULL) {
        the_proc(buffer_id, al_format, pcm_data, buffer_size, sample_rate);
    }
    
    return;
}

ALvoid alcMacOSXMixerOutputRate(const ALdouble sample_rate) {
    static alcMacOSXMixerOutputRateProcPtr the_proc = NULL;
    if (the_proc == NULL) {
        the_proc = (alcMacOSXMixerOutputRateProcPtr) alGetProcAddress((const ALCchar *) "alcMacOSXMixerOutputRate");
    }
    else {
        the_proc(sample_rate);
    }
    return;
}

//Se encarga de abrir un fichero
ExtAudioFileRef MyGetExtAudioFileRef(CFURLRef file_url, AudioStreamBasicDescription *audio_description) {
    OSStatus error_status = noErr;
    AudioStreamBasicDescription file_format;
    UInt32 property_size = sizeof(file_format);
    ExtAudioFileRef ext_file_ref = NULL;
    AudioStreamBasicDescription output_format;
    
    //Abre un archivo con ExtAudioFileOpen()
    error_status = ExtAudioFileOpenURL(file_url, &ext_file_ref);
    if (noErr != error_status) {
        printf("MyGetExtAudioFileRef: ExtAudioFileOpenURL ha fallado, error = %ld\n", error_status);
        if (ext_file_ref != NULL) {
            ExtAudioFileDispose(ext_file_ref);
        }
        return NULL;
    }
    
    //Coge el formato de datos del audio
    error_status = ExtAudioFileGetProperty(ext_file_ref, kExtAudioFileProperty_FileDataFormat, &property_size, &file_format);
    if (noErr != error_status) {
        printf("MyGetExtAudioFileRef: ExtAudioFileGetProperty(kExtAudioFileProperty_FileDataFormat) ha fallado, error = %ld\n", error_status);
        ExtAudioFileDispose(ext_file_ref);
        return NULL;
    }
    
    //Los efectos de sonido en OpenAL deben ser en mono
    
    if (file_format.mChannelsPerFrame > 2) {
        printf("MyGetExtAudioFileRef: formato no soportado, número de canales (%lu)\n", file_format.mChannelsPerFrame);
        ExtAudioFileDispose(ext_file_ref);
        return NULL;
    }
    
    //El formato de salida debe ser linear PCM ya que es el unico tipo con el que openAL puede trabajar
    //Poner el formato de salida como tipo entero con signo de 16 bits (native-endian)
    
    output_format.mSampleRate = file_format.mSampleRate; //preservar el sample rate original
    output_format.mChannelsPerFrame = file_format.mChannelsPerFrame; //preservar el número de       canales
    
    output_format.mFormatID = kAudioFormatLinearPCM;
    output_format.mFormatFlags = kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger;
    output_format.mFramesPerPacket = 1; //Para linear PCM la definicion es un frame por paquete
    
    output_format.mBitsPerChannel = 16;
    output_format.mBytesPerPacket = 2 * output_format.mChannelsPerFrame; //2 bytes (16 bits) por canal por frame
    output_format.mBytesPerFrame = 2 * output_format.mChannelsPerFrame; //1 frame es un paquete
    //Poner el formato de datos de salida correcto
    error_status = ExtAudioFileSetProperty(ext_file_ref, kExtAudioFileProperty_ClientDataFormat, sizeof(output_format), &output_format);
    if (noErr != error_status) {
        printf("MyGetExtAudioFileRef: ExtAudioFileSetProperty(kExtAudioFileProperty_ClientDataFormat) ha fallado, error = %ld\n", error_status);
        ExtAudioFileDispose(ext_file_ref);
        return NULL;
    }
    
    //Copiar el formato de salida en el audio_description. Así le devolveremos al usuario la información
    
    memcpy(audio_description, &output_format, sizeof(output_format));
    return ext_file_ref;
    
}

//Se encarga de leer datos PCM de un fichero abierto
//El calificador restrict especifica que sabemos a ciencia cierta que el puntero output_format apunta a un objeto que no es apuntado por ningún otro puntero
OSStatus MyGetDataFromExtAudioRef(ExtAudioFileRef ext_file_ref, const AudioStreamBasicDescription *restrict output_format, ALsizei max_buffer_size, void **data_buffer, ALsizei *data_bufer_size, ALenum *al_format, ALsizei *sample_rate) {
    
    OSStatus error_status = noErr;
    SInt64 buffer_size_in_frames = 0;
    
    //Calcular cuántos frames cabrán según el máximo tamaño del buffer
    buffer_size_in_frames = max_buffer_size / (*output_format).mBytesPerFrame;
    if (*data_buffer) {
        AudioBufferList audio_buffer_list;
        audio_buffer_list.mNumberBuffers = 1;
        audio_buffer_list.mBuffers[0].mDataByteSize = max_buffer_size;
        audio_buffer_list.mBuffers[0].mNumberChannels = (*output_format).mChannelsPerFrame;
        audio_buffer_list.mBuffers[0].mData = *data_buffer;
        
        //Leer los datos en AudioBufferList
        error_status = ExtAudioFileRead(ext_file_ref, (UInt32 *)&buffer_size_in_frames, &audio_buffer_list);
        if (error_status == noErr) {
            //buffer_size_in_frames == 0 significa que estamos al final del fichero
            //ExtAudioFileRead devuelve el número de frames que ha leido actualmente. Hay que volverlos a convertir a bytes.
            *data_bufer_size = (ALsizei)(buffer_size_in_frames * (*output_format).mBytesPerFrame);
            *al_format = ((*output_format).mChannelsPerFrame > 1) ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16;
            *sample_rate = (ALsizei)(*output_format).mSampleRate;
        }
        else {
            printf("MyGetDataFromExtAudioRef: ExtAudioFileRead ha fallado, error %ld\n", error_status);
        }
    }
    else {
        printf("MyGetDataFromExtAudioRef: *data_buffer es NULL\n");
    }
    return error_status;
}

//Devuelve un puntero al buffer que contiene todos los datos pcm.
//Para reservar memoria se utiliza malloc, de modo que queda en nuestras manos liberar la dicha memoria.

void *MyGetOpenALAudioDataAll(CFURLRef file_url, ALsizei *data_buffer_size, ALenum *al_format, ALsizei *sample_rate) {
    OSStatus error_status = noErr;
    SInt64 file_length_in_frames = 0;
    UInt32 property_size;
    AudioStreamBasicDescription output_format;
    ALsizei max_buffer_size;
    void *pcm_data;
    ExtAudioFileRef ext_file_ref = MyGetExtAudioFileRef(file_url, &output_format);
    if (ext_file_ref == NULL) {
        return NULL;
    }
    
    //Coger el número de frames total
    property_size = sizeof(file_length_in_frames);
    error_status = ExtAudioFileGetProperty(ext_file_ref, kExtAudioFileProperty_FileLengthFrames, &property_size, &file_length_in_frames);
    if (noErr != error_status) {
        printf("MyGetOpenALAudioDataAll: ExtAudioFileGetProperty(kExtAudioFileProperty_FileLengthFrames) failed, error = %ld\n", error_status);
        ExtAudioFileDispose(ext_file_ref);
        return NULL;
    }
    
    //Calcular los bytes que se necesitan para almacenar todos los datos del fichero
    max_buffer_size = file_length_in_frames * output_format.mBytesPerFrame;
    //Alojar memoria par almacenar los datos PCM
    pcm_data = malloc(max_buffer_size);
    if (pcm_data == NULL) {
        printf("MyGetOpenALAudioDataAll: error al alojar memoria\n");
        ExtAudioFileDispose(ext_file_ref);
        return NULL;
    }
    
    error_status = MyGetDataFromExtAudioRef(ext_file_ref, &output_format, max_buffer_size, &pcm_data, data_buffer_size, al_format, sample_rate);
    if (noErr != error_status) {
        free(pcm_data);
        ExtAudioFileDispose(ext_file_ref);
        return NULL;
    }
    
    //No se necesita más la referencia
    ExtAudioFileDispose(ext_file_ref);
    return pcm_data;
    
}















