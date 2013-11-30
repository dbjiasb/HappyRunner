//
//  MusicPlayViewController.m
//  HappyRunner
//
//  Created by chinatsp on 13-10-13.
//  Copyright (c) 2013年 chinatsp. All rights reserved.
//

#import "MusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Song : NSObject

@property (nonatomic, copy) NSString *songName;
@property (nonatomic, copy) NSString *singerName;
@property (nonatomic, copy) NSURL *songUrl;

@end

@implementation Song


@end

@interface MusicPlayViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, retain) NSMutableArray *songArray;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, assign) NSInteger sortType; //0顺序
@property (nonatomic, retain) Song *currentSong;
@end

@implementation MusicPlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _currentTag = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.songArray = [NSMutableArray array];

    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery songsQuery];
    NSArray *playlists = [myPlaylistsQuery collections];
    
    for (MPMediaPlaylist *playlist in playlists) {
        
        NSArray *songs = [playlist items];
        for (MPMediaItem *song in songs)
        {
            Song *song1 = [[Song alloc] init];
            song1.songName = [song valueForProperty: MPMediaItemPropertyTitle];
            song1.singerName = [song valueForKey:MPMediaItemPropertyPodcastTitle];
            NSURL* assetUrl = [song valueForProperty:MPMediaItemPropertyAssetURL];

            song1.songUrl = assetUrl;//[song valueForKey:MPMediaItemPropertyAssetURL];

            [self.songArray addObject:song1];

        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)controlAction:(id)sender
{
    if(self.songArray.count == 0)
    {
        
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 0) {
        //上一曲
        if (self.currentTag > 0)
        {
            self.currentTag --;
            [self playWithIndex:self.currentTag];
        }
    }
    else if(button.tag == 1)
    {
        //播放暂停
        if (self.audioPlayer && self.audioPlayer.isPlaying)
        {
            [button setImage:[UIImage imageNamed:@"btn_music_play_1"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"btn_music_play_2"] forState:UIControlStateHighlighted];
            [self.audioPlayer stop];
        }
        
        else
        {
            [button setImage:[UIImage imageNamed:@"btn_music_pause_1"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"btn_music_pause_2"] forState:UIControlStateHighlighted];

            if (self.currentTag == -1)
            {
                //未播放，开始播放
                self.currentTag = 0;
                [self playWithIndex:self.currentTag];
            }
            else
            {
                [self playWithIndex:self.currentTag];
            }
        }
    }
    else
    {
        //下一首
         if (self.currentTag >= 0 && self.currentTag + 2 < [self.songArray count])
         {
             self.currentTag ++;
             [self playWithIndex:self.currentTag];
         }
    }
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenty = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenty];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenty] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    
    Song *aSong = self.songArray[indexPath.row];
    
    cell.textLabel.text = aSong.songName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self playWithIndexPath:indexPath];
    [self didStart];

}

- (void)didStart
{
    UIButton *button = (UIButton *)[self.view viewWithTag:1];
    
    [button setImage:[UIImage imageNamed:@"btn_music_pause_1"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"btn_music_pause_2"] forState:UIControlStateHighlighted];

}

- (void)playWithIndexPath:(NSIndexPath *)indexPath
{
    
    [self playWithIndex:indexPath.row];

}

- (void)playWithIndex:(NSInteger )index
{
    self.currentTag = index;
    Song *aSong = self.songArray[index];

    [self playWithSong:aSong];
}

- (void)playWithSong:(Song *)song
{
    self.currentSong = song;
    
    playingLabel.text = [NSString stringWithFormat:@"正在播放的曲目: %@...",song.songName];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                             song.songUrl
                                                                   error:nil];
    
    self.audioPlayer = player;
    
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    [self.audioPlayer setDelegate:self];

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //下一首
    if (self.currentTag >= 0 && self.currentTag + 2 < [self.songArray count])
    {
        self.currentTag ++;
        [self playWithIndex:self.currentTag];
    }
}

@end
