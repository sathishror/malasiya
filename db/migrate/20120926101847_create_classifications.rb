class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table :classifications do |t|
      t.string :code
      t.string :title
      t.timestamps
    end

    Classification.create :code=>"A" ,:title=>"Pengangkutan"
    Classification.create :code=>"B" ,:title=>"Bakat dan Seni"
    Classification.create :code=>"C" ,:title=>"Sains"
    Classification.create :code=>"D" ,:title=>"Pendidikan"
    Classification.create :code=>"E" ,:title=>"Ekonomi"
    Classification.create :code=>"F" ,:title=>"Sistem Maklumat"
    Classification.create :code=>"G" ,:title=>"Pertanian"
    Classification.create :code=>"J" ,:title=>"Kejuruteraan"
    Classification.create :code=>"K" ,:title=>"Keselamatan dan Pertahanan Awam"
    Classification.create :code=>"L" ,:title=>"Perundangan dan Kehakiman"
    Classification.create :code=>"M" ,:title=>"Tadbir dan Diplomatik"
    Classification.create :code=>"N" ,:title=>"Pentadbiran dan Sokongan"
    Classification.create :code=>"Q" ,:title=>"Penyelidikan dan Pembangunan"
    Classification.create :code=>"R" ,:title=>"Mahir/Separuh Mahir/Tidak Mahir"
    Classification.create :code=>"S" ,:title=>"Sosial"
    Classification.create :code=>"U" ,:title=>"Perubatan dan Kesihatan"
    Classification.create :code=>"W" ,:title=>"Kewangan"
    Classification.create :code=>"X" ,:title=>"Penguatkuasaan Maritim"
    Classification.create :code=>"Y" ,:title=>"Polis"
    Classification.create :code=>"Z" ,:title=>"Angkatan Tentera Malaysia"
    Classification.create :code=>"JUSA" ,:title=>"JUSA"
    Classification.create :code=>"FT" ,:title=>"Sistem Maklumat"
    Classification.create :code=>"NP" ,:title=>"Pentadbiran dan Sokongan"
    Classification.create :code=>"NT" ,:title=>"Pentadbiran dan Sokongan"
    Classification.create :code=>"LS" ,:title=>"Perundangan dan Kehakiman Syariah"
    Classification.create :code=>"DG" ,:title=>"Perkhidmatan Pendidikan Siswazah"
    Classification.create :code=>"DGA" ,:title=>"Perkhidmatan Pendidikan Lepasan Diploma"
  end

  def self.down
    drop_table :classifications
  end
end
