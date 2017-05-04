include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|

	greetings = %w(hi hello hey ui um )
	queries = %w(question tanong ask)
	venue = %w(where saan venue)
	time = %w(when kailan time date)
	direction = %w(how paano)
	end_note = ['i see', 'ok', 'okie', 'haha', 'thanks', 'salamat', 'ohhh', ':)', ':3', '^_^', 'XD']

	collection = greetings + venue + time + direction + end_note
	fuzzy_match = FuzzyMatch.new(collection).find(message.text)

	puts collection
	puts '-' * 30
	puts fuzzy_match
	puts '-' * 30

	if greetings.include?(fuzzy_match)
		message.reply(
			text: 'Hey there! ;)'
		)
	elsif queries.include?(fuzzy_match)
		message.reply(
			text: 'Go ahead and ask me a question. :P'
		)
	elsif venue.include?(fuzzy_match)
		message.reply(
			text: 'The event is happening here!'
		)

		message.reply(
			attachment: {
		    type: 'template',
		    payload: {
		    	template_type: 'generic',
		    	elements: [
		    		{
		    			title: 'FEU Institute of Technology',
		    			subtitle: 'P. Paredes, Sampaloc, Manila',
		    			image_url: 'http://68.media.tumblr.com/6c6bb66539853c18aed9a42f8bb113bf/tumblr_inline_nb7v60Ex7D1sfo6p3.jpg',
		    			default_action: {
		    				type: 'web_url',
		    				url: 'https://maps.google.com/maps?ll=14.604161,120.988607&z=16&t=m&hl=en-US&gl=PH&mapclient=embed&cid=12487658003456722574'
		    			}
		    		}
	    		]
		    }
		  }
		)
	elsif time.include?(fuzzy_match)
		message.reply(
			text: 'The event starts at 1PM and ends at 6PM on June 2, 2017.'
		)
	elsif direction.include?(fuzzy_match)
		message.reply(
			text: 'You mean, how to get there?'
		)

		message.reply(
			text: '...how should I know :3'
		)

		message.reply(
			text: 'I can give you a map though ^_^'#,
			# attachment: {
		 #    type: 'image',
		 #    payload: {
		 #      url: 'https://maps.google.com/maps?ll=14.604161,120.988607&z=16&t=m&hl=en-US&gl=PH&mapclient=embed&cid=12487658003456722574'
		 #    }
		 #  }
		)
	elsif end_note.include?(fuzzy_match)
		message.reply(
			text: '^_^'
		)
	else
		message.reply(
			text: %(Sorry, I didn't quite catch that :/)
		)
		message.reply(
			attachment: {
		    type: 'template',
		    payload: {
		      template_type: 'button',
		      text: %(Maybe you meant to ask a question regarding one of these?),
		      buttons: [
		        { type: 'postback', title: 'Venue', payload: 'venue' },
		        { type: 'postback', title: 'Date & Time', payload: 'datetime' },
		        { type: 'postback', title: 'CS Conference 2017', payload: 'about' }
		      ]
		    }
		  }
		)
	end
end

Bot.on :postback do |postback|
	case postback.payload
	when 'venue'
		puts '-' * 30
		puts postback.recipient.id
		puts '-' * 30
		Bot.deliver(
			{
				recipient: {
					id: postback.recipient.id
				},
				message: {
					attachment: {
				    type: 'template',
				    payload: {
				    	template_type: 'generic',
				    	elements: [
				    		{
				    			title: 'FEU Institute of Technology',
				    			subtitle: 'P. Paredes, Sampaloc, Manila',
				    			image_url: 'http://68.media.tumblr.com/6c6bb66539853c18aed9a42f8bb113bf/tumblr_inline_nb7v60Ex7D1sfo6p3.jpg',
				    			default_action: {
				    				type: 'web_url',
				    				url: 'https://maps.google.com/maps?ll=14.604161,120.988607&z=16&t=m&hl=en-US&gl=PH&mapclient=embed&cid=12487658003456722574'
				    			}
				    		}
			    		]
				    }
				  }
				}	
			},
			access_token: ENV['ACCESS_TOKEN']
		)
	when 'datetime'
		Bot.deliver(
			{
				recipient: {
					id: postback.recipient
				},
				message: {
					text: 'The event starts at 1PM and ends at 6PM on June 2, 2017.'
				}	
			},
			access_token: ENV['ACCESS_TOKEN']
		)
	when 'about'
		Bot.deliver(
			{
				recipient: {
					id: postback.recipient
				},
				message: {
					text: %(FEU Tech's faculty of Computer Science holds an annual event wherein the third year students showcase their respective thesis project. This year, the event is entitled 'CS Con 2017'.)
				}	
			},
			access_token: ENV['ACCESS_TOKEN']
		)

		Bot.deliver(
			{
				recipient: {
					id: postback.recipient
				},
				message: {
					attachment: {
				    type: 'template',
				    payload: {
				    	template_type: 'generic',
				    	elements: [
				    		{
				    			title: 'CS Conference 2017',
				    			subtitle: 'feutechcs.com',
				    			image_url: 'http://feutechcs.com/images/logo.png',
				    			default_action: {
				    				type: 'web_url',
				    				url: 'http://feutechcs.com/'
				    			}
				    		}
			    		]
				    }
				  }
				}	
			},
			access_token: ENV['ACCESS_TOKEN']
		)
	end
end