// IMPORTANT: this is a specialized looper to work on a set amount of samples! It is not to be used live with the master program/sampler!

SndBuf looper => Gain loop_gain => dac;

1 => loop_gain.gain;

// Variables ============================================================
Globals globals;
PatternLooper patternLooper;
52 => int number_of_samples; // the number of samples you have prepared in target folder

4 => int sample_repeat; //the amount of times a sample should be repeated before playback moves on to next sample
int live_count; // amount of samples being played at once
int last_used_sample; // the index of the last sample called to be played
0 => int played_count; // the amount of samples that have been used overall

// run functions
spork ~ loopManager();

//keep parent running
globals.play_time::minute => now;

// playback =================
fun void loopManager(){ // this sporks each looper
    0 => live_count;
    -1 => last_used_sample;
    
    while (true){
        if (last_used_sample == number_of_samples - 1){ // uses 0 indexed array
            -1 => last_used_sample;
            <<< "resetting sample list, last used sample = " + last_used_sample >>>;
        }
        <<< "starting playback loop, sample " + Std.itoa(last_used_sample + 1) >>>;
        spork ~ loopSample(last_used_sample+1); 
        last_used_sample++;
        (sample_repeat * globals.sample_length)::second => now;
    }
}

fun void loopSample(int index){
    
    live_count++;
    index => last_used_sample;
    "audio/example_samples/sample" + index + ".wav" => looper.read;
    
    patternLooper.runPattern(looper, played_count, globals.sample_length, sample_repeat);
    
    live_count--;
    played_count++;
}