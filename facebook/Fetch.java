import java.util.List;
import org.bson.Document;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
//import com.restfb.FacebookClient.AccessToken;
import com.restfb.types.Post;

//2.ExtendedAccessToken
public class Fetch
{
	public static void main(String[] args)
	{
		MongoClient client = new MongoClient("localhost", 27017);
		MongoDatabase database = client.getDatabase("fbDB");
		MongoCollection collection = database.getCollection(args[1]);
		collection.drop();
		String accessToken = args[0];
		FacebookClient fbClient = new DefaultFacebookClient(accessToken);
		Connection<Post> result = fbClient.fetchConnection("me/feed", Post.class);
		int counter=0;
		for(List<Post> page : result )
		{
			for(Post aPost : page)
			{
				if(aPost.getMessage()!=null)
				{
					Document document = new Document();
					document.put("user_id", "fb.com/"+aPost.getId());
					document.put("post",aPost.getMessage());
					collection.insertOne(document);
					counter++;
				}
			}
		}
		//System.out.println("Data entered Successfully");
		client.close();
	}
}