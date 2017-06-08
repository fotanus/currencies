shared_examples_for "fetcher interface" do
  describe ".fetch" do
		context "when successfully retrieves the data from external api" do
			before do
				stub_request(
          :get, url_regexp
				).to_return(
					body: File.read(api_response_file_path)
				)
			end
			it "returns a hash" do
				expect(subject.class.fetch(*fetch_params)).to be_kind_of(Hash)
			end
			it "keys are dates" do
				expect(subject.class.fetch(*fetch_params).keys.first).to be_kind_of(Numeric)
			end
			it "values are price in USD" do
				expect(subject.class.fetch(*fetch_params).values.first).to be_kind_of(Numeric)
			end
		end

		context "when fails to retrieve data from external API" do
			before do
				stub_request(
          :get, url_regexp
				).to_return(
					status: [500, "Internal Server Error"]
				)
			end
			it "returns an empty hash" do
				expect(subject.class.fetch(*fetch_params)).to eq({})
			end
		end
	end
end
