require 'rails_helper'

describe Dispatcher do
  it 'exists' do
    dispatcher = create(:dispatcher)

    expect(dispatcher).to be_a(Dispatcher)
  end
  it '#generate_api_key' do
    dispatcher = create(:dispatcher)

    expect(dispatcher.api_key).to eq nil

    dispatcher.generate_api_key

    expect(dispatcher.api_key).not_to eq nil
  end
end
