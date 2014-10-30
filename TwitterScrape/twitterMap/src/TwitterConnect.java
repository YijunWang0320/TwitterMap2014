
import java.util.HashMap;
import java.util.Map;

import com.amazonaws.services.dynamodbv2.model.AttributeValue;

import twitter4j.*;



public class TwitterConnect {
    protected static DBhelper twitterDBhelper = new DBhelper(); 
    protected static MatcherHelper matcherHelper = new MatcherHelper();
    private static long count = 0;
	public static void main(String[] args) {
		count = twitterDBhelper.findId("twitterTable") + 1;
        TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
        if(!twitterDBhelper.testAndCheck("twitterTable")) {
        	System.out.println("There is no existing twitterTable,please create one first");
        	return;
        }
        StatusListener listener = new StatusListener() {
            @Override
            public void onStatus(Status status) {
                GeoLocation gl = status.getGeoLocation();
                if (gl!=null && status.getUser() != null) {
                      Map<String, AttributeValue> item = new HashMap<String, AttributeValue>();
                      item.put("id", new AttributeValue().withN(Long.toString(count)));
                      item.put("username", new AttributeValue().withS(status.getUser().getName()));
                      item.put("text",new AttributeValue().withS(status.getText()));
                      item.put("timestamp", new AttributeValue().withS(status.getCreatedAt().toString()));
                      item.put("latitude", new AttributeValue().withN(Double.toString(gl.getLatitude())));
                      item.put("longtitude", new AttributeValue().withN(Double.toString(gl.getLongitude())));
                      item.put("keyword", new AttributeValue().withS(matcherHelper.iskeyword(status.getText())));
                      item.put("url", new AttributeValue().withS(status.getSource()));
                      count++;
                      twitterDBhelper.addItem("twitterTable", item);
				}
            }

            @Override
            public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
                //System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
            }

            @Override
            public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
                System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
            }

            @Override
            public void onScrubGeo(long userId, long upToStatusId) {
                System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
            }

            @Override
            public void onStallWarning(StallWarning warning) {
                System.out.println("Got stall warning:" + warning);
            }

            @Override
            public void onException(Exception ex) {
                ex.printStackTrace();
            }
        };
        twitterStream.addListener(listener);
        /*twitterStream.addRateLimitStatusListener(new RateLimitStatusListener() {
			
			@Override
			public void onRateLimitStatus(RateLimitStatusEvent arg0) {
				System.out.println(arg0.getRateLimitStatus().getRemaining());
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void onRateLimitReached(RateLimitStatusEvent arg0) {
				arg0.notifyAll();  //may be to have something wait on this event to controll the limit, not needed in this project
				// TODO Auto-generated method stub
				
			}
		});*/
        twitterStream.sample();
        
	}
}