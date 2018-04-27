//
//  BufferingStateSpecs.swift
//  RxAudioPlayerSMTests
//
//  Created by raphael ankierman on 28/02/2018.
//  Copyright © 2018 raphael ankierman. All rights reserved.
//

import Foundation
import Quick
import ModernAVPlayer
import Nimble

final class BufferingStateSpecs: QuickSpec {

    private var bufferingState: BufferingState!
    private var mockPlayer = MockCustomPlayer()
    private var playerMedia = ConcretePlayerMedia(url: URL(string: "x")!, type: .clip)
    private lazy var tested = ConcretePlayerContext(player: self.mockPlayer)

    override func spec() {
        beforeEach {
            self.bufferingState = BufferingState(context: self.tested)
            self.tested.state = self.bufferingState
        }

        context("loadMedia") {
            it("should update state context to LoadingMedia") {

                // ACT
                self.bufferingState.loadMedia(media: self.playerMedia, shouldPlaying: false)

                // ASSERT
                expect(self.tested.state).to(beAnInstanceOf(LoadingMediaState.self))
            }
        }

        context("play") {
            it("should not update state context") {

                // ACT
                self.bufferingState.play()

                // ASSERT
                expect(self.tested.state).to(beIdenticalTo(self.bufferingState.self))
            }
        }

        context("stop") {
            it("should update state context to Stopped") {

                // ACT
                self.bufferingState.stop()

                // ASSERT
                expect(self.tested.state).to(beAnInstanceOf(StoppedState.self))
            }
        }

        context("pause") {
            it("should update state context to Paused") {

                // ACT
                self.bufferingState.pause()

                // ASSERT
                expect(self.tested.state).to(beAnInstanceOf(PausedState.self))
            }
        }
    }
}