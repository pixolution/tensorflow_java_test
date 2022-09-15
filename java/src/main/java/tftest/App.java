package tftest;

import java.util.Collections;

import org.tensorflow.SavedModelBundle;
import org.tensorflow.ndarray.NdArrays;
import org.tensorflow.ndarray.Shape;
import org.tensorflow.proto.framework.ConfigProto;
import org.tensorflow.proto.framework.GPUOptions;
import org.tensorflow.proto.framework.GraphOptions;
import org.tensorflow.proto.framework.OptimizerOptions;
import org.tensorflow.proto.framework.OptimizerOptions.GlobalJitLevel;
import org.tensorflow.proto.framework.OptimizerOptions.Level;
import org.tensorflow.types.TFloat32;

public class App {
	
	private final static String modelPath = "/tmp/vit_b32_fe/";

    public static void main(String[] args) {
        System.out.println("Testing query without ConfigProto");
	    try (SavedModelBundle savedModel = SavedModelBundle.loader(modelPath).withTags(new String[]{"serve"}).load()) {
	    	doInference(savedModel, "Java: Model without ConfigProto");
	    }
	    System.out.println("Testing query with ConfigProto");
		ConfigProto config = ConfigProto.newBuilder(ConfigProto.getDefaultInstance())
                .setLogDevicePlacement(false)
                .setGraphOptions(GraphOptions.newBuilder()
                    .setOptimizerOptions(
                  		  OptimizerOptions.newBuilder()
			                      .setCpuGlobalJit(false)
			            		  .setGlobalJitLevel(GlobalJitLevel.OFF)
			            		  .setDoCommonSubexpressionElimination(false)
			            		  .setDoConstantFolding(false)
			            		  .setDoFunctionInlining(false)
			            		  .setOptLevel(Level.L0)
			                      .build()
			           )
                 ).setGpuOptions(
              		   GPUOptions.newBuilder()
		                      .setForceGpuCompatible(false)
		                      .setAllowGrowth(true)
		                      .setPerProcessGpuMemoryFraction(0.5)
		                      .build()
                 ).build();
	    try (SavedModelBundle savedModel = SavedModelBundle.loader(modelPath).withConfigProto(config).withTags(new String[]{"serve"}).load()) {
	    	doInference(savedModel, "Java: Model with ConfigProto/disabled JIT");
	    }
	    
    }
    
    public static void doInference(SavedModelBundle savedModel, String msg) {
		long start = System.currentTimeMillis();
	    if (System.getenv().containsKey("TF_XLA_FLAGS")) {
	    	System.out.println("TF_XLA_FLAGS="+System.getenv().get("TF_XLA_FLAGS"));
	    } else {
	    	System.out.println("TF_XLA_FLAGS not set");
	    }
	    try (TFloat32 xTensor = TFloat32.tensorOf(NdArrays.ofFloats(Shape.of(1,244,244,3)));
	    	 TFloat32 zTensor = (TFloat32) savedModel
	                    .call(Collections.singletonMap("inputs", xTensor))
	                    .get("output_0")) {
	    	long end = System.currentTimeMillis();
	    	System.out.println(msg + ", warm up took "+((end-start)/1000f)+" seconds");
	    
	    }
    }
}
