//
//  FashionStore.m
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionStore.h"
#import "NSURLSession.h"
#import "News.h"

#define KEY_RESULTS @"posts"

@implementation FashionStore

#pragma mark Singleton

+ (instancetype)shared {
    static dispatch_once_t predicate;
    static FashionStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

#pragma mark news requests

- (void)requestNews:(NSInteger)page withCompletion:(void(^)(NSArray *news, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://fashion.ie/api/get_posts?page=%lu",page]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *news = [self isListJsonOK:json] ? [self newsArrayWithJSON:json[KEY_RESULTS]] : nil; // Get the result
        dispatch_async_main(^{
            completion(news, nil);
        }); // Execute completion block
    }];
    
    
//    NSArray *arrDummy = [self getDummyNews];
//    completion (arrDummy, nil);
}

//! Returns array of news from JSON
- (NSArray *)newsArrayWithJSON:(id)json {
    NSMutableArray *newsArray = [NSMutableArray new];
    for (NSDictionary *item in json) {
        News *news = [self newsFromJSON:item];
        //To Skip upcoming movies coming in theaters tab.
        if (news)
            [newsArray addObject:news];
    }
    return newsArray.count > 0 ? newsArray : nil;
}

//! Check if we got correct list result from api
- (BOOL)isListJsonOK:(id)json {
    return json && json[@"status"] && [json[KEY_RESULTS] count] > 0;
}

//! Returns news object from actor JSON
- (News *)newsFromJSON:(id)json {
    News *new = [News new];
    new.title = json[@"title"];
    new.imageUrl = json[@"thumbnail"];
    new.date = json[@"date"];
    new.contentWeb = json[@"content"];
    return new;
}

- (NSArray *)getDummyNews {
    NSArray *titles = @[@"How to master the cropped flare",
                        @"Thursdays made Tantalising at Dress of Dreams",
                        @"How to wear florals this winter",
                        @"Glitter & gold is good this party season",
                        @"The Penneys Primark lust-worthy Lingerie",
                        @"Pirelli Calendar 2016 goes physique not nude",
                        @"Quiet chair hairdressers",
                        @"Ireland’s Best Dressed Debutante 2015 is?",
                        @"Kylie Jenner’s wheelchair shoot causes upset",
                        @"Fashion at the Order of St Lazarus"];
    NSArray *descriptions = @[@"Irish fashion news, Just when you’ve mastered the culotte, flare and the wide-leg slacks, along comes another trouser style to get your head around. A report by Fashion Fix @ The Herald.ie The cropped flare, or “clare” as the fash pack call them, are a favourite of Alexa Chung and other street-style stars, plus it’s the new jean shape for winter. Longer than a culotte and shorter than your standard flare, two specific attributes rolled into one trouser, it’s the fresh new cut and a daring trend to say the least.I can’t lie – they aren’t the easiest to wear, but I’m always up for a fashion challenge. At first, I was nervous -surely these are the territory of only the tall and slim? Flares can be scary enough without adding the extra dimension of being cropped. I’ve been eyeing them in street-style pictures for a while, stalking them on catwalks, and spying celebs wearing them and now, here I am, wearing the trousers.",
                              @"Dress of Dreams boutique, located in Harold’s Cross, Dublin recently held a very exclusive evening of beautiful fashion and informative styling tips, hosted by the ever glamourous and professional stylist Caroline McElroy. Guests were treated to a feast of looks perfect for occasion and high glamour while also receiving a pretty little goody bag with discount vouchers for the store.Customers were eager to re-invent some of the fashionable looks presented on the night and many items were purchased or ordered immediately afterwards. On the night one lucky lady received the winning raffle ticket which meant she had won a beautiful Obi Frock Art dress. Also announced were details of ‘Tantalising Thursdays’ which will see the store open late Thursday evenings and will include flash offers and many discounts being offered on that day. Owners Dee and Trish welcome you to drop in and check out their latest ranges.",
                              @"Irish fashion news. We all know florals are the perfect choice for spring, but I’d prefer we break them out a little earlier. Story by Corina Gaffey of the Herald.ie. We’ve still got a few months left of the cold weather, so your wardrobe may be the only place to see a few beautiful blooms, and a sweet, pretty bouquet is just the right look for gloomy, winter weather.Lead by fashion designers like Preen, Erdem, and Dolce & Gabbana on the winter runways, the florals of the moment are set on a dark canvas rather than white or soft pastel – and during these dark winter days, I’m all about the moodier palette.",
                              @"Velvets and metallics, glitter and sequins: they all have magical properties. These are the fabrics and textures of the party season ahead, as the family reunions, office shindigs and general merriment get into full swing. Here’s how to wear them with a minimum of fuss and maximum impact. A report by Sarah Waldron of the Irishtimes.com.Don’t be deceived. Just because it doesn’t glitter, velvet can still be a bounteous vein in the fashion goldmine. This lush, multidimensional material catches the light and moves when you do, but unfortunately it doesn’t translate well to pictures. On a hanger, a velvet piece can look sad and static. On a woman, it’s life itself.",
                              @"Irish fashion news. Primark’s lingerie collection is the hot topic of the LOOK office right now. And for very good reason. Lauren O’Callaghan of Look.co.uk reports. From lace overlays and satin fabrics, to pretty pinks and pastel mint greens, Primark’s lingerie range has covered all the bases and is only getting better with its new-in offerings.We’re completely obsessed with the gorgeous new ivory babydoll and matching thong set, which would work perfectly as pretty wedding night lingerie or just as a simple set to sleep in. The delicate bow detailing adds a touch of playfulness to the design, and the intricate lace back detailing gives it a luxe feel. Guaranteed to make you feel instantly glamorous at bedtime? Most definitely. Primark’s latest range of women’s underwear boasts a sea of sheer panelling, lace detailing and soft satin. The colour palette includes summer pastels and nude shades, as well as classic black and white colourways to compliment your everyday wardrobe. Criss-cross straps also feature heavily, which can turn even the most simple bra design into an instant feature – simply layer underneath a low-back top or dress.",
                              @"Irish fashion news. The first four images from the 2016 Pirelli Calendar, shot by Annie Leibovitz, have been unveiled, along with the month that they will represent. A report by Scarlett Conlon of Vogue.co.uk. For next year, more than any other, the big reveal has been highly anticipated due to the fact that the publication has undergone something of a change in direction. Far from the scantily-clad, PVC adorned pin-ups of 2015, for 2016 the images are focused on the women in the photographs rather than their physiques and, as in 2002, 2008 and 2013, there are no nudes.",
                              @"Irish fashion news. For anyone who dreads the 50 minutes of awkward conversation a haircut warrants, there’s – at last – a ‘silent’ hairdressers chair in town. A report by Sejal Kapadia of stylist.co.uk.Bauhaus, a newly-refurbished Aveda hair salon in Cardiff, and it’s sister salon of the same name, are offering a no chat treatment reports walesonline.co.uk. Owner, Scott Miller, says it’s to allow salon-goers to switch off in an information age where it can be difficult to find peace and quiet. “We understand people lead busy lives where they may have been communicating with people all day and want some relief,” he says. “A trip to the hair salon is supposed to be relaxing, and while for some people that means catching up on what’s been going on in their lives, not everybody is comfortable with small talk. “We wanted to take the embarrassment away, and for customers to know we won’t be offended if they don’t want to do the small talk often associated with visiting the hair salon.”",
                              @"Irish fashion news. The title went to Eve Rochfort (17), from Dublin’s Navan Road, who was also crowned Overall Beauty at Dream Debs & Ireland’s Ultimate Debutante awards. A report by Kirsty Blake Knox of independent.ie.Eve went for a strapless white gown with a dipped hemline from Spanish Boutique which she teamed with pink sandals. “I couldn’t believe it when they called my name,” she said. “I was so surprised and so grateful.” The Most Stylish Male title went to Joe Judge (18), from Bettystown, Co Meath, who cited Cristiano Ronaldo as his style inspiration.",
                              @"Irish fashion news. It’s not unusual for a Kardashian-fronted magazine cover to spark headlines, but Kylie Jenner’s Interview magazine shoot is causing controversy for all the wrong reasons. A report by the Telegraph.co.uk. Photographer Steven Klein, famous for his surreal shoots, has captured the reality star turned fashion icon sitting in a gold wheelchair – something that’s being slated by disability campaigners on social media.Part of the magazine’s Art Issue, the shoot is accompanied by an interview with the 18-year-old talking about how insecure she sometimes feels about her very-public life. Talking about her anti-bullying campaign on instagram #IAmMoreThan, she says one of her biggest fears is seeing negativity about her circulating online. ‘Like, every single day I see something negative about me. And it’s just completely torn me apart,’ she tells the magazine. All of which means Kylie might want to avoid the internet right now, as people have taken to twitter to accuse her of ableism.",
                              @"The Order of St Lazarus, Grand Priory of Ireland held there annual investiture which was held in St Patricks Cathedral which was followed by the annual charity fund raising Gala Dinner, last Saturday 28th November 2015, in the Kings Inns just off Henrietta Street.This Annual Charity event raised vital funds for 3 very worthy causes. The recipients of this year’s Gala Dinner were Nyumbani Kenya, a charity that provides a home and education for AIDS children in Kenya."];
    
    NSArray *imageNames = @[@"image1.jpg",
                            @"image2.jpg",
                            @"image3.jpg",
                            @"image4.jpg",
                            @"image5.jpg",
                            @"image6.jpg",
                            @"image7.jpg",
                            @"image8.jpg",
                            @"image9.jpg",
                            @"image10.jpg"];
    
    NSMutableArray *arrData = [NSMutableArray new];
    for (int i = 0; i <[titles count]; i++) {
        News *new = [News new];
        new.title = titles[i];
        new.newsDescription = descriptions[i];
        new.imageUrl = imageNames[i];
        [arrData addObject:new];
    }
    return arrData;
}

@end


