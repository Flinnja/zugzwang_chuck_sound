public class PatternLooper{
    // i know this is a gross big list but events werent working the way i thought so here we are
    
    fun void runPattern(SndBuf source, int sample_number, float sample_length, int sample_repeat){
        if (sample_number % 10 == 0){
            <<< "pattern 1" >>>;
            for (0 => int i; i < sample_repeat; i++){
                0 => source.pos;
                sample_length::second => now;
            }
        }
        else if (sample_number % 10 == 1) {
            <<< "pattern 2" >>>;
            for (0 => int i; i < sample_repeat; i++){
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*80)::second => now;
            }
        }
        else if (sample_number % 10 == 2) {
            <<< "pattern 3" >>>;
            for (0 => int i; i < sample_repeat/2; i++){
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*80)::second => now;
                // at 100 
                0 => source.pos;
                (sample_length/100*100)::second => now;
            }
        }
        else if (sample_number % 10 == 3) {
            <<< "pattern 4" >>>;
            for (0 => int i; i < sample_repeat; i++){
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
            }
        }
        else if (sample_number % 10 == 4) {
            <<< "pattern 5" >>>;
            for (0 => int i; i < sample_repeat/2; i++){
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
                // at 100
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*80)::second => now;
            }
        }
        else if (sample_number % 10 == 5) {
            <<< "pattern 6" >>>;
            for (0 => int i; i < sample_repeat/2; i++){
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
                // at 100
                0 => source.pos;
                (sample_length/100*100)::second => now;
            }
        }
        else if (sample_number % 10 == 6) {
            <<< "pattern 7" >>>;
            for (0 => int i; i < sample_repeat; i++){
                0 => source.pos;
                (sample_length/100*30)::second => now;
                0 => source.pos;
                (sample_length/100*10)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
            }
        }
        else if (sample_number % 10 == 7) {
            <<< "pattern 8" >>>;
            for (0 => int i; i < sample_repeat/2; i++){
                0 => source.pos;
                (sample_length/100*30)::second => now;
                0 => source.pos;
                (sample_length/100*10)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
                // at 100
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;

            }
        }
        else if (sample_number % 10 == 8) {
            <<< "pattern 9" >>>;
            for (0 => int i; i < sample_repeat/2; i++){
                0 => source.pos;
                (sample_length/100*30)::second => now;
                0 => source.pos;
                (sample_length/100*10)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
                // at 100
                0 => source.pos;
                (sample_length/100*20)::second => now;
                0 => source.pos;
                (sample_length/100*80)::second => now;
                
            }
        }
        else if (sample_number % 10 == 9) {
            <<< "pattern 10" >>>;
            for (0 => int i; i < sample_repeat/2; i++){
                0 => source.pos;
                (sample_length/100*30)::second => now;
                0 => source.pos;
                (sample_length/100*10)::second => now;
                0 => source.pos;
                (sample_length/100*60)::second => now;
                // at 100
                0 => source.pos;
                (sample_length/100*100)::second => now;
            }
        }
    }
}