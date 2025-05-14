# 概要

複数のデータ構造の管理

クロージャ

@Environment

@Previewable

# 参考

https://developer.apple.com/tutorials/app-dev-training/updating-app-data


# 説明資料

https://note.com/sakiyamak/n/nf40752b88f98

# Environmentについて

SampleEnvironmentのプロジェクトを参照

次の順序で解説している

SampleEnvironment>StringEnvironmentView.swift
SampleEnvironment>GlobalParameterView.swift
SampleEnvironment>ThemeSettingsEnvironmentView.swift
SampleEnvironment>TabEnvironmentView.swift

上記は全て自前でカスタムなEnvironmentを作って利用しているが、
SwiftUIはある程度のEnvironmentを用意してくれているので、
カスタムする前に標準のEnvironmentがあるか調べること

# 06からの追加/変更箇所

## 追加
History.swift
NewScrumSheet.swift

## 変更
DailyScrum.swift
DetailEditView.swift
DetailView.swift
MeetingView.swift