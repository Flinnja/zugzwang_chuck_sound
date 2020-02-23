adc => Gain sampler_gain => WvOut sampler => blackhole; // setup a unit generator that will send input from the mic to a .wav file

1 => sampler.gain;
0 => sampler_gain.gain;

GainRamp ramp;

// Variables ============================================================
Globals globals;

globals.sample_length - (2 * (globals.sample_ramp_length / 1000)) => float sample_record_length; //adjust sample length to include ramp time


// run functions
spork ~ samplerRecord();

//keep parent running
globals.play_time::minute => now;

//Recording Samples ============================================================
fun void samplerRecord(){
    while (true){
        for (0 => int i; i < globals.max_samples; i++){
            <<< "recording open, sample " + Std.itoa(i) >>>;
            globals.recorded_samples[i] => sampler.wavFilename;
            ramp.gainRamp(sampler_gain, "up", globals.sample_ramp_length);
            sample_record_length::second => now;
            ramp.gainRamp(sampler_gain, "down", globals.sample_ramp_length);
            globals.recorded_samples[i] => sampler.closeFile;
            // <<< "recording closed, sample " + Std.itoa(i) >>>;
            globals.time_between_samples::second => now;
        }
        <<< "Sample limit of " + Std.itoa(globals.max_samples) + " reached; recording over previous samples" >>>;
    }
}
