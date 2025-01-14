require "frame"

RSpec.describe Frame do
  before(:each) do
    @frame = Frame.new(false)
  end

  context "#initialize" do
    it "should create a new Frame with empty scores" do
      expect(@frame.scores).to eq [0, 0]
    end
  end

  context "#add_score" do
    it "should add scores to the correct roll until the frame ended." do
      @frame.add_score(4)
      expect(@frame.scores).to eq [4, 0]
      @frame.add_score(2)
      expect(@frame.scores).to eq [4, 2]
      # This shouldn't take any effect on the scores
      @frame.add_score(8)
      expect(@frame.scores).to eq [4, 2]
    end
  end

  context "#total_score" do
    it "should return the total score of the frame" do
      @frame.add_score(2)
      @frame.add_score(8)
      expect(@frame.total_score).to eq 10
    end
  end

  context "#is_ended?" do
    it "should return a correct boolean" do
      @frame.add_score(2)
      expect(@frame.is_ended?).to be false
      @frame.add_score(8)
      expect(@frame.is_ended?).to be true
    end

    it "should end the frame when the first score is 10" do
      @frame.add_score(10)
      expect(@frame.is_ended?).to be true
    end

    it "should end on the 3rd roll if the frame is the 10th" do
      frame = Frame.new(true)
      frame.add_score(10)
      expect(frame.is_ended?).to be false
      frame.add_score(10)
      expect(frame.is_ended?).to be false
      frame.add_score(10)
      expect(frame.is_ended?).to be true
    end

    it "should end on the 2nd roll if the play can't play a strike or spare" do
      frame = Frame.new(true)
      frame.add_score(2)
      expect(frame.is_ended?).to be false
      frame.add_score(7)
      expect(frame.is_ended?).to be true
    end
  end

  context "#status" do
    it "should return 'strike' when the first roll is 10" do
      @frame.add_score(10)
      expect(@frame.status).to eq "strike"
    end

    it "should return 'spare' when the sum of two rolls is 10" do
      @frame.add_score(2)
      @frame.add_score(8)
      expect(@frame.status).to eq "spare"
    end

    it "should return 'normal' when none of above is matched" do
      @frame.add_score(4)
      @frame.add_score(5)
      expect(@frame.status).to eq "normal"
    end
  end
end
