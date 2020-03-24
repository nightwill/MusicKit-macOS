//
//  Player.swift
//  MusicKit
//
//  Created by Nate Thompson on 2/11/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import Foundation

open class Player {
    public var queue: Queue
    private var mkWebController: MKWebController
    
    init(webController: MKWebController) {
        mkWebController = webController
        queue = Queue(webController: mkWebController)
    }
    
    // MARK: Properties
    /// The current playback duration.
    public func getCurrentPlaybackDuration(completionHandler: @escaping (Int) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.currentPlaybackDuration",
            type: Int.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    /// The current playback progress.
    public func getCurrentPlaybackProgress(completionHandler: @escaping (Double) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.currentPlaybackProgress",
            type: Double.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    /// The current position of the playhead.
    public func getCurrentPlaybackTime(completionHandler: @escaping (Int) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.currentPlaybackTime",
            type: Int.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    public func getCurrentPlaybackTimeRemaining(completionHandler: @escaping (Int) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.currentPlaybackTimeRemaining",
            type: Int.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }

    
    /// A Boolean value indicating whether the player is currently playing.
    public func getIsPlaying(completionHandler: @escaping (Bool) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.isPlaying",
            type: Bool.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    /// The currently-playing media item, or the media item, within an queue, that you have designated to begin playback.
    public func getNowPlayingItem(completionHandler: @escaping (MediaItem?) -> Void) {
        mkWebController.evaluateJavaScript(
            "JSON.stringify(music.player.nowPlayingItem)",
            type: MediaItem?.self,
            decodingStrategy: .jsonString,
            onSuccess: completionHandler)
    }
    
    /// The index of the now playing item in the current playback queue. If there is no now playing item, the index is -1.
    public func getNowPlayingItemIndex(completionHandler: @escaping (Int) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.nowPlayingItemIndex",
            type: Int.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    //    /// The current playback rate for the player.
    //    public func getPlaybackRate(completionHandler: @escaping (Int?) -> Void) {
    //
    //    }
    
    /// The current playback state of the music player.
    public func getPlaybackState(completionHandler: @escaping (PlaybackStates) -> Void) {
        mkWebController.evaluateJavaScript(
            "music.player.playbackState",
            type: PlaybackStates.self,
            decodingStrategy: .enumType,
            onSuccess: completionHandler)
    }
    
//    /// A Boolean value that indicates whether a playback target is available.
//    public func getPlaybackTargetAvailable(completionHandler: @escaping (Bool?) -> Void) {
//
//    }
//
//    /// The current repeat mode of the music player.
//    public func getRepeatMode(completionHandler: @escaping (PlayerRepeatMode?) -> Void) {
//
//    }
//
//    /// The current shuffle mode of the music player.
//    public func getShuffleMode(completionHandler: @escaping (PlayerShuffleMode?) -> Void) {
//
//    }
//
//    /// A number indicating the current volume of the music player.
//    public func getVolume(completionHandler: @escaping (Int?) -> Void) {
//
//    }
    
    // MARK: Methods
    
    /// Begins playing the media item at the specified index in the queue immediately.
    public func changeToMediaAtIndex(_ index: Int, completionHandler: (() -> Void)? = nil) {
        mkWebController.evaluateJavaScriptWithPromise(
            "music.player.changeToMediaAtIndex(\(index))",
            onSuccess: completionHandler)
    }
    
//    /// Begins playing the media item in the queue immediately.
//    public func changeToMediaItem(id: MediaID, completionHandler: (() -> Void)? = nil) {
//
//    }
    
    /// Sets the volume to 0.
    public func mute() {
        mkWebController.evaluateJavaScript("music.player.mute()")
    }
    
    /// Pauses playback of the current item.
    public func pause() {
        mkWebController.evaluateJavaScript("music.player.pause()")
    }
    
    /// Initiates playback of the current item.
    public func play() {
        mkWebController.evaluateJavaScript("music.player.play()")
    }
    
    public func togglePlayPause() {
        getPlaybackState { playbackState in
            switch playbackState {
            case .playing:
                MusicKit.shared.player.pause()
            case .paused, .stopped, .ended:
                MusicKit.shared.player.play()
            default:
                break
            }
        }
    }
    
//    /// Prepares a music player for playback.
//    public func prepareToPlay(mediaItem: MediaItem, onSuccess: (() -> Void)? = nil, onError: @escaping (Error) -> Void) {
//        mkWebController.evaluateJavaScriptWithPromise(
//            "music.player.prepareToPlay()",
//            onSuccess: onSuccess,
//            onError: onError)
//    }
    
    /// Sets the playback point to a specified time.
    public func seek(to time: Double, completionHandler: (() -> Void)? = nil) {
        mkWebController.evaluateJavaScriptWithPromise(
            "music.player.seekToTime(\(time))",
            onSuccess: completionHandler)
    }
    
//    /// Displays the playback target picker if a playback target is available.
//    public func showPlaybackTargetPicker() {
//        mkWebController.evaluateJavaScript("music.player.showPlaybackTargetPicker()")
//    }
    
    /// Starts playback of the next media item in the playback queue.
    /// Returns the current media item position.
    public func skipToNextItem(completionHandler: ((Int) -> Void)? = nil) {
        mkWebController.evaluateJavaScriptWithPromise(
            "music.player.skipToNextItem()",
            type: Int.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    /// Starts playback of the previous media item in the playback queue.
    /// Returns the current media position.
    public func skipToPreviousItem(completionHandler: ((Int) -> Void)? = nil) {
        mkWebController.evaluateJavaScriptWithPromise(
            "music.player.skipToPreviousItem()",
            type: Int.self,
            decodingStrategy: .typeCasting,
            onSuccess: completionHandler)
    }
    
    /// Stops the currently playing media item.
    public func stop() {
        mkWebController.evaluateJavaScript("music.player.stop()")
    }
}
