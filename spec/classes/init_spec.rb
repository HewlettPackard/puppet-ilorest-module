require 'spec_helper'
describe 'ilorest' do

  context 'with default values for all parameters' do
    it { should contain_class('ilorest') }
  end
end
