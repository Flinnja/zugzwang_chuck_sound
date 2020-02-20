SawOsc saw => Gain g => Dyno d => dac;

// dynamic limiter to avoid ear splitting!

0.5 => float maxAmp; 
/* 1.0 is maximum output before distortion, 
so choose something less than that */

g.gain(maxAmp); 
/* scale everything by that amount, so that what's 1.0 in your
original code is simply scaled to be 1.0 * maxAmp */

d.thresh(maxAmp);  // set the threshold of the limiter
d.slopeBelow(1.0); // sound quieter than thresh is untouched
d.slopeAbove(0.0); // sound louder than thresh is squashed

// END dynamic limiter