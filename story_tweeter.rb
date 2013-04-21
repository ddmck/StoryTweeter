require 'twitter'

Twitter.configure do |config|
  config.consumer_key = 'YOUR_CONSUMER_KEY'
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
  config.oauth_token = "YOUR_OAUTH_TOKEN"
  config.oauth_token_secret = "YOUR_OAUTH_SECRET"
end

# Finds a place to stop that isn't mid-word
def logical_stop(cut)
  until cut[-1] == " "
    cut = cut[0..-2]
  end
  return cut
end

# Splits the text into 
def chunker(tweet)
  sample = logical_stop(tweet[0,135])
  return sample, tweet[sample.length..-1]
end   

def recurring(tweet)
  tweets = Hash.new
  n = 1
  until tweet.length < 135
    sample, tweet = chunker(tweet)
    tweets[n] = sample
    n += 1
  end
  return tweet, n, tweets
end

def multi_tweet(hash, n)
  (1..n).each do |part|
    Twitter.update(hash[part] + "(#{part}/#{n})")
    # For Testing without submitting to twitter
    #puts (hash[part] + "(#{part}/#{n})")
  end
end

print "Enter your tweet>"
tweet = gets.chomp

if tweet.length > 140
  puts "That is too long for just one tweet!"
  puts "Chopping it up for you, please wait!"
  tweet, n, tweets = recurring(tweet)
  tweets[n] = tweet
  multi_tweet(tweets, n)
else
  Twitter.update(tweet)
end
