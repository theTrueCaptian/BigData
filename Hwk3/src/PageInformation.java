
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.util.ArrayList;

/**
 * A custom Writable implementation for Request information.
 *
 * This is simple Custom Writable, and does not implement Comparable or RawComparator
 */
public class PageInformation implements Writable  {

  
	private Text name;
    // this page's PageRank
    private FloatWritable pageRank;

    //OR this page's list of outlinks
    private Text outlinks;
  
    private boolean isOutlink = false;

    public PageInformation(){
    	name = new Text();
    	pageRank = new FloatWritable();
    	outlinks = new Text();
    }
    
    public PageInformation( Text name, FloatWritable pageRank) {
        this.pageRank = pageRank;
        this.name = name;
        this.isOutlink = false;
    }

    //@outlinks e.g. "C F"
    public PageInformation( Text name, Text outlinks) {
        this.name = name;
        this.outlinks = outlinks;
        this.isOutlink = true;
    }

    public boolean isOutlinkInformation(){
    	return this.isOutlink;
    }

    public void write(DataOutput dataOutput) throws IOException {
     	name.write(dataOutput);

    	if(isOutlink)
    		outlinks.write(dataOutput);
    	else
    		pageRank.write(dataOutput);
    	
     }

    public void readFields(DataInput dataInput) throws IOException {
     	name.readFields(dataInput);

    	if(isOutlink)
    		outlinks.readFields(dataInput);
    	else
    		pageRank.readFields(dataInput);
    	
          
    }
    
    public Text getName(){
    	return this.name;
    }
    
    public FloatWritable getPageRank(){
    	return this.pageRank;
    }
    
    public Text getOutlinks(){
    	return this.outlinks;
    }

    
}


