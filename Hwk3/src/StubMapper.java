import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class StubMapper extends Mapper<LongWritable, Text, Text, Text> {

  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {			
			
		  	String line = value.toString();
			System.out.println(line);
			StringTokenizer tokenizer = new StringTokenizer(line, " ");
	        
			//The first char is the current page
			Text mainPage = new Text(tokenizer.nextToken());
			//Information to collect during the loop through all tokens:
 			FloatWritable pageRank = null;
			ArrayList<Text> outlinks = new ArrayList<Text>();
 			Text outlinksSTR = new Text("");
 			 			
	        //iterating through all pages that point to mainPage
			while (tokenizer.hasMoreTokens())
			{
				//Be sure that it is not a float
				String currentToken = tokenizer.nextToken();
				if(isStringDecimal(currentToken)){
					pageRank = new FloatWritable(Float.parseFloat(currentToken));
	 				System.out.println("page rank: "+pageRank);

					break;
				}else{
					String currentPage = currentToken.charAt(0)+"";
	 				System.out.println("current page: "+currentPage);
	 				
	 				//Add to outlinks
	 				if(!outlinksSTR.equals(new Text(""))){
	 					outlinksSTR.set(outlinksSTR.toString()+ " ");
	 				}
	 				outlinksSTR.set(outlinksSTR.toString()+currentPage);
	 				
	 				outlinks.add(new Text(currentPage));
	 				
				}
			}
			
			
 			//Send reducers outlink information for each page e.g. A <C, F>
			context.write(mainPage,  outlinksSTR);//new PageInformation(mainPage, outlinksSTR));
			
			for(Text outlink: outlinks){
				//Write out the values e.g. C <A, PR/2> and  F <A, PR/2> 
				context.write(outlink, new Text(""+(pageRank.get()/outlinks.size())));//new PageInformation(mainPage, new FloatWritable(pageRank.get()/outlinks.size())));
			}

  }
  
  public boolean isStringDecimal(String test){
	  String decimalPattern = "([0-9]*)\\.([0-9]*)";
	  boolean patternMatch = Pattern.matches(decimalPattern, test);
	  return patternMatch;
  }
  
}
