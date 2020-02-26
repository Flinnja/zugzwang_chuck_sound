// Run classes to initialise
Machine.add("classes/GainRamp.ck");
Machine.add("classes/PatternLooper.ck");
Machine.add("classes/Globals.ck");
Machine.add("tools/record_out.ck"); // records whatever is sent to dac

10::second => now; // wait 30 seconds to get on treadmill etc

Machine.add("sampler.ck");
//Machine.add("live_monitor.ck");
4::second => now; // this should equal at least the sample length time
1::ms => now; //not necessary if the above is greater than the sample length
Machine.add("looper.ck");
 