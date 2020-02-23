public class GainRamp{
    fun void gainRamp (Gain gain, string direction, float length){ //ramp sampler volume quickly up or down to avoid pops at either end of recording
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
}