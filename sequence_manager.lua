local sequence_manager = {}

sequence_manager.sequences = {}
sequence_manager.currentSequence = nil
sequence_manager.captureFirstFrame = nil
sequence_manager.currentActionIndex = 1

function sequence_manager.startSequence(sequence)
  sequence_manager.currentSequence = sequence
  sequence_manager.captureFirstFrame = nil
  sequence_manager.currentActionIndex = 1
end

function sequence_manager.stopSequence()
  sequence_manager.currentSequence = nil
  sequence_manager.captureFirstFrame = nil
  sequence_manager.currentActionIndex = 1
end

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
