include Facebook::Messenger

Facebook::Messenger::Profile.set({
  get_started: {
    payload: 'GET_STARTED_PAYLOAD'
  }
}, access_token: ENV['ACCESS_TOKEN'])

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :postback do |postback|
	case postback.payload
	when 'GET_STARTED_PAYLOAD'
		Bot.deliver(
			{
				recipient: {
					id: postback.sender['id']
				},
				message: {
					text: %Q(Hi #{postback.sender}, thanks for your message. We are not here right now, but we'll get back to you soon!)
				}
			},
			access_token: ENV['access_token']
		)

		Bot.deliver(
			{
				recipient: {
					id: postback.sender['id']
				},
				message: {
					attachment: {
						type: 'template',
						payload: {
							template_type: 'button',
							text: %(In the meantime, you might want to check these out:),
							buttons: [
								{ type: 'postback', title: 'Venue', payload: 'venue' },
								{ type: 'postback', title: 'Date & Time', payload: 'datetime' },
								{ type: 'postback', title: 'CS Conference 2017', payload: 'about' }
							]
						}
					}
				}	
			}, 
			access_token: ENV['access_token']
		)
	when 'venue'
		Bot.deliver(
			{
				recipient: {
					id: postback.sender['id']
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
					id: postback.sender['id']
				},
				message: {
					text: 'The event starts at 1PM and ends at 6PM on June 6, 2017.'
				}	
			},
			access_token: ENV['ACCESS_TOKEN']
		)
	when 'about'
		Bot.deliver(
			{
				recipient: {
					id: postback.sender['id']
				},
				message: {
					text: %(FEU Tech's faculty of Computer Science holds an annual event wherein the third year students showcase their respective thesis project.)
				}	
			},
			access_token: ENV['ACCESS_TOKEN']
		)

		Bot.deliver(
			{
				recipient: {
					id: postback.sender['id']
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
