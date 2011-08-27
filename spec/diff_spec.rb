# -*- ruby encoding: utf-8 -*-

require 'spec_helper'

describe "Diff::LCS.diff" do
  include Diff::LCS::SpecHelper::Matchers

  it "should correctly diff seq1 to seq2" do
    diff_s1_s2 = Diff::LCS.diff(seq1, seq2)
    change_diff(correct_forward_diff).should == diff_s1_s2
  end

  it "should correctly diff seq2 to seq1" do
    diff_s2_s1 = Diff::LCS.diff(seq2, seq1)
    change_diff(correct_backward_diff).should == diff_s2_s1
  end

# describe "should, when diffing 'aX' and 'bXaX'," do
#   before(:each) do
#     @s1 = "aX"
#     @s2 = "bXaX"
#     @correct_diff = [
#       [ [ '+', 0, 'b' ],
#         [ '+', 1, 'X' ] ]
#     ]
#   end
#
#   it "compare them correctly forward" do
#     change_diff(@correct_diff).should == Diff::LCS.diff(@s1, @s2)
#   end
#
#   it "compare them correctly backward" do
#     @correct_diff.each { |hunk| hunk.each { |change| change[0] = '-' } }
#     change_diff(@correct_diff).should == Diff::LCS.diff(@s2, @s1)
#   end
# end

  it "should correctly diff against an empty sequence" do
    diff = Diff::LCS.diff(word_sequence, [])
    correct_diff = [
      [ [ '-', 0, 'abcd'           ],
        [ '-', 1, 'efgh'           ],
        [ '-', 2, 'ijkl'           ],
        [ '-', 3, 'mnopqrstuvwxyz' ] ]
    ]

    change_diff(correct_diff).should == diff

    diff = Diff::LCS.diff([], word_sequence)
    correct_diff.each { |hunk| hunk.each { |change| change[0] = '+' } }
    change_diff(correct_diff).should == diff
  end
end

# vim: ft=ruby
