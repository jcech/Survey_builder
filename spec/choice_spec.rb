require 'spec_helper'

describe Choice do
  it { should belong_to :user}
  it { should belong_to :answer}
end
