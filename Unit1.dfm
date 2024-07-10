object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 714
  Top = 131
  Height = 150
  Width = 234
  object ZConnection: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    HostName = 'localhost'
    Port = 3306
    Database = 'penjualan'
    User = 'root'
    Protocol = 'mysql'
    LibraryLocation = 
      'D:\Kuliah\SEMESTER IV\VISUAL\TUGAS UTS VISUAL\M.Haldi 2210010283' +
      '_Tugas UTS\libmysql.dll'
    Left = 24
    Top = 40
  end
  object Zsatuan: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'select * from satuan')
    Params = <>
    Left = 88
    Top = 40
  end
  object dssatuan: TDataSource
    DataSet = Zsatuan
    Left = 152
    Top = 40
  end
end
