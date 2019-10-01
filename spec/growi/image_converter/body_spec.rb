# frozen_string_literal: true

RSpec.describe Growi::ImageConverter::Body do
  describe '#scan_markdown_image_esa' do
    shared_examples 'match regular expression' do
      it { expect(body.scan_markdown_image_esa.size).to eq 1 }
    end

    shared_examples 'not match regular expression' do
      it { expect(body.scan_markdown_image_esa.size).to eq 0 }
    end

    context 'Image syntax inline' do
      context '一般的なパターン' do
        let(:body) { Growi::ImageConverter::Body.new('![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの前方にスペースが1つ' do
        let(:body) { Growi::ImageConverter::Body.new('![ img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、改行' do
        let(:body) { Growi::ImageConverter::Body.new("![ \nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、タブ、改行' do
        let(:body) { Growi::ImageConverter::Body.new("![ \t\nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、改行が2つ' do
        let(:body) { Growi::ImageConverter::Body.new("![ \n\nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの前方にスペース、改行、スペース、改行' do
        let(:body) { Growi::ImageConverter::Body.new("![ \n \nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの前方に改行、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![\n img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方に改行が2つ、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![\n\n img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの前方に改行、スペース、改行、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![\n \n img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの前方に改行が2つ' do
        let(:body) { Growi::ImageConverter::Body.new("![\n\nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの前方にスペース、改行、スペース、改行、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![ \n \n img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'alt_textの後方にスペースが1つ' do
        let(:body) { Growi::ImageConverter::Body.new('![img2019011_23134932.jpeg (354.3 kB) ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB) \n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、タブ、改行' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB) \t\n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行が2つ' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB) \n\n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの後方にスペース、改行、スペース、改行' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB) \n \n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの後方に改行、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB)\n ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行が2つ、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB)\n\n ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの後方に改行、スペース、改行、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB)\n \n ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの後方に改行が2つ' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB)\n\n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end

      context 'urlの後方にスペース、改行、スペース、改行、スペース' do
        let(:body) { Growi::ImageConverter::Body.new("![img2019011_23134932.jpeg (354.3 kB) \n \n ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'not match regular expression'
      end
    end

    context 'Image syntax reference-style' do
    end

    context 'Image syntax img tag' do
    end
  end

  describe '#replace_markdown_image' do
  end
end
