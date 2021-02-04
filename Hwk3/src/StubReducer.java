import java.io.IOException;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class StubReducer extends Reducer<Text, Text, Text, Text> {

  @Override
  public void reduce(Text key, Iterable<Text> values, Context context)
      throws IOException, InterruptedException {

	  Text outputLine = new Text(key+" ");
	  
	  /*float pagerank = 0f;
	  //Calculate pagerank by summing all PR values from PageRank
	  for(PageInformation info: values){
		  //Either it is outlink, e.g.  A <C, F>, OR PR value, e.g. F <A, PR/2> 
		  if(info.isOutlinkInformation()){
			  outputLine.set(new Text(outputLine.toString()+info.getOutlinks()+" "));
		  }else{
			  pagerank = pagerank + info.getPageRank().get();
		  }
		  
	  }
	  
	  outputLine.set(new Text(outputLine.toString()+pagerank));
	  context.write(key, new Text("Go"));//outputLine);
	  */
	  
	  float pagerank = 0f;
	  String outlinks = "";
	  for(Text info: values){
		  //Either it is outlink, e.g.  A <C, F>, OR PR value, e.g. F <A, PR/2> 
		  StringTokenizer tokenizer = new StringTokenizer(info.toString(), " ");
		  while (tokenizer.hasMoreTokens()){
			  String currentToken = tokenizer.nextToken();
			  
			  //Check if the current token is a float, which we count as page rank value.
			  if(isPRInformation(currentToken)){
				  
				  //Add the page rank values
				  pagerank = pagerank + Float.parseFloat(currentToken);
			  
			  }else{
				  
				  //Save the outlinks i.e. A C F
				  outlinks = info.toString();
		
			  }
			  
		  }
	  }
	  
	  //Write out the values 
	  context.write(key, new Text(outlinks+" "+pagerank));
	  
		  
	  
	  //
	  
     

  }
  
  public boolean isPRInformation(String test){
	  String decimalPattern = "([0-9]*)\\.([0-9]*)";
	  boolean patternMatch = Pattern.matches(decimalPattern, test);
	  return patternMatch;
  }
}