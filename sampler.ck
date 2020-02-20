adc => Gain sampler_gain => WvOut sampler => blackhole; // setup a unit generator that will send input from the mic to a .wav file

1 => sampler.gain;
0 => sampler_gain.gain;

// Variables ============================================================
// Static
90 => int max_samples; // maximum amount of samples that will be saved as .wav files
4 => float sample_length; // desired sample length in seconds - ramp time will be included in this
56 => float time_between_samples; // time in seconds to wait after one sample is done recording before taking another
100 => float sample_ramp_length; // desired gain ramp length in ms
90 => float play_time; // desired time to run the program for in minutes

sample_length - (2 * (sample_ramp_length / 1000)) => sample_length; //adjust sample length to include ramp time


// Declared
string recorded_samples[max_samples]; // declare array to store filenames of samples
for (0 => int i; i < recorded_samples.cap(); i++){
    "audio/samples/sample" + Std.itoa(i) => recorded_samples[i]; // files will be named sample1, sample2 etc
}

// run functions
spork ~ SamplerRecord();

//keep parent running
play_time::minute => now;

//Recording Samples ============================================================
fun void SamplerRecord(){
    while (true){
        for (0 => int i; i < max_samples; i++){
            <<< "recording open" >>>;
            recorded_samples[i] => sampler.wavFilename;
            GainRamp(sampler_gain, "up", sample_ramp_length);
            sample_length::second => now;
            GainRamp(sampler_gain, "up", sample_ramp_length);
            recorded_samples[i] => sampler.closeFile;
            <<< "recording closed" >>>;
            time_between_samples::second => now;
        }
        <<< "Sample limit of " + Std.itoa(max_samples) + " reached; recording over previous samples" >>>;
    }
}

// Gain Ramp for fading clips
fun void GainRamp (Gain gain, string direction, float length){ //ramp sampler volume quickly up or down to avoid pops at either end of recording
    0.5/length => float adjustment_amount; // always ramp to 0.5
    if (direction == "up"){
        for (0 => int i; i < length; i++){
            gain.gain()+adjustment_amount => gain.gain;
            1::ms => now;
        }
    }
    else if (direction == "down" ){
        for (0 => int i; i < length; i++){
            if (gain.gain() > 0) gain.gain()-adjustment_amount => gain.gain;
            1::ms => now;
        }
    }
}