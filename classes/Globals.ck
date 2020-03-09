public class Globals{
    // Global Variables
    90 => int max_samples; // maximum amount of samples that will be saved as .wav files
    4 => float sample_length; // desired sample length in seconds - ramp time will be included in this
    10 => float time_between_samples; // time in seconds to wait after one sample is done recording before taking another
    100 => float sample_ramp_length; // desired gain ramp length in ms
    1440 => float play_time; // desired time to run the program for in minutes
    
    string recorded_samples[max_samples]; // declare array to store filenames of samples
    for (0 => int i; i < recorded_samples.cap(); i++){
        "audio/samples/sample" + Std.itoa(i) => recorded_samples[i]; // files will be named sample1, sample2 etc
    }
}