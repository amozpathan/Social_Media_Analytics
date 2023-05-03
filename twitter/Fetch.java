import java.util.List;
import org.bson.Document;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import twitter4j.Status;
import twitter4j.Paging;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class Fetch
{
	private static MongoClient client;

	public static void main(String[] args) throws TwitterException
	{

		client = new MongoClient("localhost", 27017);
		MongoDatabase database = client.getDatabase("twitterDB");
		MongoCollection collection = database.getCollection(args[4]);
		collection.drop();
		ConfigurationBuilder cf=new ConfigurationBuilder();
		cf.setDebugEnabled(true)
			.setOAuthConsumerKey(args[0])
			.setOAuthConsumerSecret(args[1])
			.setOAuthAccessToken(args[2])
			.setOAuthAccessTokenSecret(args[3]);
		TwitterFactory tf=new TwitterFactory(cf.build());
		twitter4j.Twitter twitter=tf.getInstance();
		//List<Status> status = twitter.getHomeTimeline();
		int totalTweets = 150; // no of tweets to be fetched
		Paging paging = new Paging(1, totalTweets);
		List<Status> tweets = twitter.getHomeTimeline(paging);
		for(Status st : tweets)
		{
			if(st.getLang().equals("en"))
			{
			Document document = new Document();
			document.put("user",st.getUser().getName());
			document.put("text",st.getText());
			document.put("lang",st.getLang());
			collection.insertOne(document);
			//System.out.println(st.getUser().getName()+"------"+st.getLang());
			}
		}
	}
}