// Run classes to initialise
Machine.add("classes/GainRamp.ck");
Machine.add("classes/PatternLooper.ck");

Machine.add("sampler.ck");
4::second => now; // this should equal at least the sample length time
1::ms => now; //not necessary if the above is greater than the sample length
Machine.add("looper.ck");