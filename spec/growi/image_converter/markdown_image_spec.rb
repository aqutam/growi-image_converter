# frozen_string_literal: true

RSpec.describe Growi::ImageConverter::MarkdownImage do
  describe '#initialize' do
    shared_examples 'match regular expression' do
      it { expect(markdown_image.url).to eq 'https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg' }
    end

    context 'Image syntax inline' do
      context '一般的なパターン' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの前方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('![ img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの前方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![\nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの前方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![ \nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの前方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![ \t\nimg2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの前方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![\n img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの後方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('![img2019011_23134932.jpeg (354.3 kB) ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの後方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)\n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの後方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB) \n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの後方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB) \t\n](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'alt_textの後方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)\n ](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('![img2019011_23134932.jpeg (354.3 kB)]( https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)') }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](\nhttps://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)]( \nhttps://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)]( \t\nhttps://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](\n https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg )') }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \t\n)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n )") }
        it_behaves_like 'match regular expression'
      end

      context 'urlにタイトルあり' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg "title")') }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n\"title\")") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \t\n\"title\")") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n \"title\")") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n \"title\")") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n\"title\")") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \t\n)") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n )") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\"\n )") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("![img2019011_23134932.jpeg (354.3 kB)](https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\"\n)") }
        it_behaves_like 'match regular expression'
      end
    end

    context 'Image syntax reference-style' do
      context '一般的なパターン' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg') }
        it_behaves_like 'match regular expression'
      end

      context 'idの前方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('[ image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg') }
        it_behaves_like 'match regular expression'
      end

      context 'idの前方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[\nimage_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの前方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[ \nimage_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの前方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[ \t\nimage_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの前方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[\n image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの後方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('[image_zuguro ]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg') }
        it_behaves_like 'match regular expression'
      end

      context 'idの後方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro\n]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの後方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro \n]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの後方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro \t\n]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'idの後方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro\n ]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]:\nhttps://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: \nhttps://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: \t\nhttps://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの前方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]:\n https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペースが1つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg ') }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \t\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行が2つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n\t\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行、スペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n \n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行が2つ、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n\n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行、スペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n \n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方に改行が2つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlの後方にスペース、改行、スペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n \n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlにタイトルあり' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg "title"') }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n\"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \t\n\"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行2つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n\n\"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n\t\n\"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行、スペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n \n\"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行、スペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n \n \"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方に改行、スペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n \n \"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方にスペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \n \"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n \"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの前方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg\n\"title\"") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \t\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行2つ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行、タブ、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n\t\n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行、スペース、改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n \n") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行、スペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n \n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方に改行、スペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\"\n \n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方にスペース、改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\" \n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方に改行、スペース' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\"\n ") }
        it_behaves_like 'match regular expression'
      end

      context 'urlのタイトルの後方に改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new("[image_zuguro]: https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg \"title\"\n") }
        it_behaves_like 'match regular expression'
      end
    end

    context 'Image syntax img tag' do
      context '一般的なパターン' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('<img src="https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg">') }
        it_behaves_like 'match regular expression'
      end

      context 'src以外の複数の属性' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('<img title="title" src="https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg" width="100" height="100">') }
        it_behaves_like 'match regular expression'
      end

      context '末尾にスラッシュ' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('<img src="https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg"/>') }
        it_behaves_like 'match regular expression'
      end

      context '区切りに改行' do
        let(:markdown_image) { Growi::ImageConverter::MarkdownImage.new('<img\nsrc="https://img.esa.io/uploads/production/attachments/12345/2019/01/01/12345/e849b365-e40b-4e52-8bd9-57c7e1a737be.jpeg"\n>') }
        it_behaves_like 'match regular expression'
      end
    end
  end
end
