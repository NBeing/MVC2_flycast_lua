-- sequence_manager.sequences: A table to store defined sequences. This is useful if you want to predefine multiple sequences and reference them by name.
-- sequence_manager.currentSequence: Stores the sequence that is currently being executed.
-- sequence_manager.captureFirstFrame: Captures the frame number when the current sequence starts. It is used to calculate the time elapsed between actions.
-- sequence_manager.currentActionIndex: Tracks the index of the current action in the sequence.
-- sequence_manager.startSequence(sequence): Starts the given sequence by initializing the necessary variables.
-- sequence_manager.stopSequence(): Stops the current sequence by resetting the relevant variables.
-- sequence_manager.runSequence(): This function should be called every frame (e.g., in the vBlank callback). It checks if it's time to execute the next action in the sequence and performs the action if the required number of frames has passed since the last action. Once all actions in the sequence are completed, the sequence is stopped.
-- This module manages sequences of actions to be executed over multiple frames.
local sequence_manager = {}

-- Table to store defined sequences.
sequence_manager.sequences = {}

-- Currently running sequence, if any.
sequence_manager.currentSequence = nil

-- Frame number when the current sequence started.
sequence_manager.captureFirstFrame = nil

-- Index of the current action in the sequence.
sequence_manager.currentActionIndex = 1

-- Function to start a sequence.
-- @param sequence A table representing the sequence of actions.
function sequence_manager.startSequence(sequence)
  sequence_manager.currentSequence = sequence
  sequence_manager.captureFirstFrame = nil
  sequence_manager.currentActionIndex = 1
end

-- Function to stop the current sequence.
function sequence_manager.stopSequence()
  sequence_manager.currentSequence = nil
  sequence_manager.captureFirstFrame = nil
  sequence_manager.currentActionIndex = 1
end

-- Function to run the sequence actions based on the current frame number.
function sequence_manager.runSequence()
  if not sequence_manager.currentSequence then
    return
  end

  local currentFrame = flycast.state.getFrameNumber()

  if not sequence_manager.captureFirstFrame then
    sequence_manager.captureFirstFrame = currentFrame
  end

  local frameDifference = currentFrame - sequence_manager.captureFirstFrame

  if sequence_manager.currentActionIndex <= #sequence_manager.currentSequence and frameDifference >=
    sequence_manager.currentSequence[sequence_manager.currentActionIndex].waitFrames then
    sequence_manager.currentSequence[sequence_manager.currentActionIndex].action()
    sequence_manager.currentActionIndex = sequence_manager.currentActionIndex + 1
    sequence_manager.captureFirstFrame = currentFrame
  end

  if sequence_manager.currentActionIndex > #sequence_manager.currentSequence then
    sequence_manager.stopSequence()
  end
end

return sequence_manager
