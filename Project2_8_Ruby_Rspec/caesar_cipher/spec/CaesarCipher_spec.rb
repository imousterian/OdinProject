require './lib/CaesarCipher'

describe "caesar's cipher" do

    it "handles a bad factor input" do
        expect { caesar_cipher("shifts a given input", "foo") }.to raise_error ArgumentError
    end

    it "shifts a given input by a given factor" do
        expect(caesar_cipher("hello", 3)).to eql "khoor"
    end

    it "preserves capital letters" do
        expect(caesar_cipher("helloWorld", 3)).to eql "khoorZruog"
    end

    it "preserves the location of non-letter characters" do
        expect(caesar_cipher("Hello, my World! Error 404", 3)).to eql "Khoor, pb Zruog! Huuru 404"
    end

    it "handles a given input if a given factor is zero" do
        expect(caesar_cipher("error", 0)).to eql "error"
    end

    it "wraps around z" do
        expect(caesar_cipher("zoo", 10)).to eql "jyy"
    end


end
