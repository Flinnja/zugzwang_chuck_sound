adc => WvOut sampler => blackhole; // setup a unit generator that will send input from the mic to a .wav file

0 => sampler.gain;

// Variables ============================================================
// Static
90 => int max_samples; // maximum amount of samples that will be saved as .wav files
4 => float sample_length; // desired sample length in seconds - ramp time will be included in this
56 => float time_between_samples; // time in seconds to wait after one sample is done recording before taking another
500 => float ramp_length; // desired gain ramp length in ms
90 => float play_time; // desired time to run the program for in minutes

sample_length - (2 * (ramp_length / 1000)) => sample_length; //adjust sample length to include ramp time


// Declared
string recorded_samples[max_samples]; // declare array to store filenames of samples
for (0 => int i; i < recorded_samples.cap(); i++){
    "samples/sample" + Std.itoa(i) => recorded_samples[i]; // files will be named sample1, sample2 etc
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
            GainRamp("up");
            sample_length::second => now;
            GainRamp("down");
            recorded_samples[i] => sampler.closeFile;
            <<< "recording closed" >>>;
            time_between_samples::second => now;
        }
        <<< "Sample limit of " + Std.itoa(max_samples) + " reached; recording over previous samples" >>>;
    }
}

//MINOR FUNCTIONS ============================================================
//volume ramp for sampling clips
fun void GainRamp (string direction){ //ramp sampler volume quickly up or down to avoid pops at either end of recording
    if (direction != "up" && direction != "down"){
        "up" => direction;
        <<< "GainRamp defaults to up as incorrect argument was sent" >>>;
    }
    if (direction == "up"){
        for (0 => int i; i < ramp_length; i++){
            sampler.gain()+0.001 => sampler.gain;
            1::ms => now;
        }
    }
    else if (direction == "down" ){
        for (0 => int i; i < 500; i++){
            if (sampler.gain() > 0) sampler.gain()-0.001 => sampler.gain;
            1::ms => now;
        }
    }
}