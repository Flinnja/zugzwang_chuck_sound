SndBuf looper => dac;

PatternLooper patternLooper;

// Variables ============================================================
90 => int max_samples; // maximum amount of samples that will be saved as .wav files
4 => float sample_length; // desired sample length in seconds - ramp time will be included in this
10 => float time_between_samples; // time in seconds to wait after one sample is done recording before taking another
100 => float sample_ramp_length; // desired gain ramp length in ms
90 => float play_time; // desired time to run the program for in minutes

4 => int sample_repeat; //the amount of times a sample should be repeated before playback moves on to next sample
int live_count; // amount of samples being played at once
int last_used_sample; // the index of the last sample called to be played
0 => int played_count; // the amount of samples that have been used overall

string recorded_samples[max_samples]; // declare array to store filenames of samples
for (0 => int i; i < recorded_samples.cap(); i++){
    "audio/samples/sample" + Std.itoa(i) => recorded_samples[i]; // files will be named sample1, sample2 etc
}

// run functions
spork ~ loopManager();

//keep parent running
play_time::minute => now;

// playback =================
fun void loopManager(){ // this sporks each looper
    0 => live_count;
    -1 => last_used_sample;
    
    while (true){
        // <<< "starting playback loop, sample " + Std.itoa(last_used_sample + 1) >>>;
        spork ~ loopSample(last_used_sample+1); 
        if (last_used_sample < max_samples) last_used_sample++;
        else -1 => last_used_sample;
        (sample_repeat * sample_length)::second => now;
    }
}

fun void loopSample(int index){
    
    live_count++;
    index => last_used_sample;
    recorded_samples[index] + ".wav" => looper.read;

    patternLooper.runPattern(looper, played_count, sample_length, sample_repeat);
    
    live_count--;
    played_count++;
}