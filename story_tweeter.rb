require 'twitter'

Twitter.configure do |config|
  config.consumer_key = 'xpfzDCbIPB0ov9z7geHXQ'
  config.consumer_secret = "wVdsySYlqjLMSZJvETVmwYh0JMTjJp5cVVMmOZlT76o"
  config.oauth_token = "49119925-OLoz9wBpJTZcRISNgPxUqOeipmu1V9oWfS1cYigli"
  config.oauth_token_secret = "Wk4Wzej3hAL90VXHoQs4ui0YDNLkfotbaoUH4GQOKKs"
end

# Finds a place to stop that isn't mid-word
def logical_stop(cut)
  until cut[-1] == " "
    cut = cut[0..-2]
  end
  return cut
end

# Splits the text into chunks
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
