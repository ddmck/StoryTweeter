require 'twitter'

Twitter.configure do |config|
  config.consumer_key = 'YOUR_CONSUMER_KEY'
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
  config.oauth_token = "YOUR_OAUTH_TOKEN"
  config.oauth_token_secret = "YOUR_OAUTH_SECRET"
end

def logical_stop(cut)
  until cut[-1] == " "
    cut = cut[0..-2]
  end
  return cut
end

def chunker(tweet, num)
  sample = logical_stop(tweet[0,135])
  return sample, tweet[sample.length..-1]
end   

def recurring(tweet)
  tweets = Hash.new
  n = 1
  until tweet.length < 131
    sample, tweet = chunker(tweet, n)
    tweets[n] = sample
    n += 1
  end
  return tweet, n, tweets
end

def multi_tweet(array, n)
  part = 1
  until part > n
    Twitter.update(array[part] + "(#{part}/#{n})")
    # For Testing without submitting to twitter
    #puts (array[part] + "(#{part}/#{n})")
    part += 1
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
