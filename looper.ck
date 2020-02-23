SndBuf looper => Gain loop_gain => dac;

1 => loop_gain.gain;

PatternLooper patternLooper;

// Variables ============================================================
Globals globals;

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
        // <<< "starting playback loop, sample " + Std.itoa(last_used_sample + 1) >>>;
        spork ~ loopSample(last_used_sample+1); 
        if (last_used_sample < globals.max_samples) last_used_sample++;
        else -1 => last_used_sample;
        (sample_repeat * globals.sample_length)::second => now;
    }
}

fun void loopSample(int index){
    
    live_count++;
    index => last_used_sample;
    globals.recorded_samples[index] + ".wav" => looper.read;

    patternLooper.runPattern(looper, played_count, globals.sample_length, sample_repeat);
    
    live_count--;
    played_count++;
}