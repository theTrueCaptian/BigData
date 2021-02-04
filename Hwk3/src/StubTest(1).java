import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Mapper.Context;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mrunit.mapreduce.MapDriver;
import org.apache.hadoop.mrunit.mapreduce.MapReduceDriver;
import org.apache.hadoop.mrunit.mapreduce.ReduceDriver;

import static org.junit.Assert.fail;

import org.junit.Before;
import org.junit.Test;

public class StubTest {

  /*
   * Declare harnesses that let you test a mapper, a reducer, and
   * a mapper and a reducer working together.
   */
  MapDriver<LongWritable, Text, Text, PageInformation> mapDriver;
  ReduceDriver<Text, PageInformation, Text, Text> reduceDriver;
  MapReduceDriver<LongWritable, Text, PageInformation, Text, Text, Text> mapReduceDriver;

  /*
   * Set up the test. This method will be called before every test.
   */
  @Before
  public void setUp() {

   
  }

  /*
   * Test the mapper.
   */
  @Test
  public void testMapper() throws IOException, InterruptedException {

    /*
     * For this test, the mapper's input will be "1 cat cat dog" 
     * TODO: implement
     */
     new StubMapper().map(null , new Text("A C F 0.166667"), null);
  }

  /*
   * Test the reducer.
   */
  @Test
  public void testReducer() {

    /*
     * For this test, the reducer's input will be "cat 1 1".
     * The expected output is "cat 2".
     * TODO: implement
     */
    fail("Please implement test.");

  }


  /*
   * Test the mapper and reducer working together.
   */
  @Test
  public void testMapReduce() {

    /*
     * For this test, the mapper's input will be "1 cat cat dog" 
     * The expected output (from the reducer) is "cat 2", "dog 1". 
     * TODO: implement
     */
    fail("Please implement test.");

  }
}
