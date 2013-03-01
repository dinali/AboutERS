/*
     File: DataController.m
 Abstract: A simple controller class responsible for managing the application's data.
 Typically this object would be able to load and save a file containing the appliction's data. This example illustrates just the basic minimum: it creates an array containing information about some plays and provides simple accessor methods for the array and its contents.
  Version: 3.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "DataController.h"
//#import "Play.h"

#import "Publication.h"


@interface DataController ()
//@property (nonatomic, copy, readwrite) NSMutableArray *list;
- (void)createDemoData;
@end


@implementation DataController

@synthesize list;


- (id)init {
    if (self = [super init]) {
        [self createDemoData];
    }
    return self;
}

// Custom set accessor to ensure the new list is mutable.
- (void)setList:(NSMutableArray *)newList {
    if (list != newList) {
        list = [newList mutableCopy];
    }
}

// Accessor methods for list.
- (unsigned)countOfList {
    return [list count];
}

//- (Play *)objectInListAtIndex:(unsigned)theIndex {
- (Publication *)objectInListAtIndex:(unsigned)theIndex {

    return [list objectAtIndex:theIndex];
}


- (void)createDemoData {
    
    /*
     Create an array containing some demonstration data.
     Each data item is a Play that contains information about a play -- its list of characters, its genre, and its year of publication.  Typically the data would be comprised of instances of custom classes rather than dictionaries, but using dictionaries means fewer distractions in the example.
     */
    
    NSMutableArray *playList = [[NSMutableArray alloc] init];
    Publication *publication;
	publication = [[Publication alloc] init];
	publication.titleName = @"Water Conservation in Irrigated Agriculture: Trends and Challenges in the Face of Emerging Demands";
	publication.author = @"Glenn Schaible and Marcel Aillery";
	publication.pubDate = @"September 2012";
    publication.longDescription = @"This report relies on findings from several national surveys and current literature to assess water resource use and conservation measures within the U.S. irrigated crop sector. U.S. agriculture accounts for 80-90 percent of the Nation’s consumptive water use (water lost to the environment by evaporation, crop transpiration, or incorporation into products). Expanding water demands to support population and economic growth, environmental flows (water within wetlands, rivers, and groundwater systems needed to maintain natural ecosystems), and energy-sector growth, combined with Native American water-right claims and supply/demand shifts expected with climate change, will present new challenges for agricultural water use and conservation, particularly for the 17 Western States that account for nearly three-quarters of U.S. irrigated agriculture. Despite technological innovations, at least half of U.S. irrigated cropland acreage is still irrigated with less efficient, traditional irrigation application systems. Sustainability of irrigated agriculture will depend partly on whether producers adopt more efficient irrigation production systems that integrate improved on farm water management practices with efficient irrigation application systems.";
    publication.shortDescription = @"This report relies on findings from several national surveys and current literature to assess water resource use and conservation measures within the U.S. irrigated crop sector.";
    publication.pdfURL = @"http://www.ers.usda.gov/media/884158/eib99.pdf";
    publication.keywords = @"Agricultural water conservation, irrigated agriculture, irrigation efficiency, water supply and demand, irrigation technologies, water management practices, water conservation policy";
    
	[playList addObject:publication];
    
    publication = [[Publication alloc] init];
	publication.titleName = @"Agricultural Adaptation to a Changing Climate: Economic and Environmental Implications Vary by U.S. Region";
	publication.author = @"Scott Malcolm, Elizabeth Marshall, Marcel Aillery, Paul Heisey, Michael Livingston, and Kelly Day-Rubenstein";
	publication.pubDate = @"July 2012";
    publication.longDescription = @"Global climate models predict increases over time in average temperature worldwide, with significant impacts on local patterns of temperature and precipitation. The extent to which such changes present a risk to food supplies, farmer livelihoods, and rural communities depends in part on the direction, magnitude, and rate of such changes, but equally importantly on the ability of the agricultural sector to adapt to changing patterns of yield and productivity, production cost, and resource availability. Study findings suggest that, while impacts are highly sensitive to uncertain climate projections, farmers have considerable flexibility to adapt to changes in local weather, resource conditions, and price signals by adjusting crops, rotations, and production practices. Such adaptation, using existing crop production technologies, can partially mitigate the impacts of climate change on national agricultural markets. Adaptive redistribution of production, however, may have significant implications for both regional land use and environmental quality.";
    publication.shortDescription = @"Study findings suggest that, while impacts are highly sensitive to uncertain climate projections, farmers have considerable flexibility to adapt to changes in local weather, resource conditions, and price signals by adjusting crops, rotations, and production practices. Such adaptation, using existing crop production technologies, can partially mitigate the impacts of climate change on national agricultural markets. Adaptive redistribution of production, however, may have significant implications for both regional land use and environmental quality.";
    publication.pdfURL = @"http://www.ers.usda.gov/media/848748/err136.pdf";
    publication.keywords = @"Climate change, adaptation, water resources, agricultural pests, Regional Environment and Agriculture Programming (REAP) model, regional crop mix, regional environmental effects, drought tolerance, pest management";
    
	[playList addObject:publication];
    
    publication = [[Publication alloc] init];
	publication.titleName = @"Another title about climate change";
	publication.author = @"Scott the Great";
	publication.pubDate = @"July 2012";
    publication.longDescription = @"Global climate change models predict that we will roast.";
    publication.shortDescription = @"Study findings suggest that the world will end in 20 years.";
    publication.pdfURL = @"http://www.ers.usda.gov/media/848748/err136.pdf";
    publication.keywords = @"Climate change, adaptation, water resources, agricultural pests, Regional Environment and Agriculture Programming (REAP) model, regional crop mix, regional environmental effects, drought tolerance, pest management";
    
	[playList addObject:publication];
    
    publication = [[Publication alloc] init];
	publication.titleName = @"Climate Change Is Terrible";
	publication.author = @"Jane Smith";
	publication.pubDate = @"July 2012";
    publication.longDescription = @"Get ready for terrible weather and no food.";
    publication.shortDescription = @"This is a study funded by the government";
    publication.pdfURL = @"http://www.ers.usda.gov/media/848748/err136.pdf";
    publication.keywords = @"Climate change, adaptation, water resources, agricultural pests, Regional Environment and Agriculture Programming (REAP) model, regional crop mix, regional environmental effects, drought tolerance, pest management";
    
	[playList addObject:publication];
    
    publication = [[Publication alloc] init];
	publication.titleName = @"Don't Forget to Delete This";
	publication.author = @"Test Data";
	publication.pubDate = @"July 2012";
    publication.longDescription = @"Global climate change should be taken seriously";
    publication.shortDescription = @"Study findings suggest that farmers can make a difference in battling climate change.";
    publication.pdfURL = @"http://www.ers.usda.gov/media/848748/err136.pdf";
    publication.keywords = @"Climate change, adaptation, water resources, agricultural pests, Regional Environment and Agriculture Programming (REAP) model, regional crop mix, regional environmental effects, drought tolerance, pest management";
    
	[playList addObject:publication];
    
    self.list = playList;
}

@end
