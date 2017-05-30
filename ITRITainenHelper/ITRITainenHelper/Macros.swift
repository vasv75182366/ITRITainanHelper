//
//  Macros.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/23/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

public class Constants {
    
    // MARK: - List of MACROs
    
    static let MAIN_BAR_TITLE = "台南洽公小幫手"
    // put sqlite in app's Documents directory
    static let DB_PATH = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    static let DB_NAME = "itriTainan.sqlite"
    static let DB_FULLPATH = DB_PATH + DB_NAME
    static let DATABASE_PATH = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    static let FULL_DATABASE_NAME = "\(Constants.DATABASE_PATH)/check.sqlite"
    
    static let SHOW_ADMINISTRATIVE_UNIT_BY_CATEGORY_ID = 1
    static let SHOW_ADMINISTRATIVE_UNIT_BY_KEYWORD = 2
    static let SHOW_ADMINISTRATIVE_UNIT_BY_OBJECT = 3
    static let REQUEST_ADMINISTRATIVE_UNIT = 1
    static let RESULT_CANCELED = 0
    static let SHOW_ADMINISTRATIVE_UNIT = 1
    static let RESULT_NAVIGATION = 2
    
    static let POSITION = "position"
    static let NAVIGATION_CODE = "navigationCode"
    static let MAIN_PAGE_SEARCH_DATA = "mainPageSearchData"
    
    static let ACTION_SETTINGS = "Settings"
    
    static let DATA_STATUS_SYNC = "資料中下載中，請稍候..."
    
    static let HELLO_BLANK_FRAGMENT = "Hello blank fragment"
    static let LABEL_TEXT = "Label"
    static let LARGE_TEXT = "   Nature, in the broadest sense, is the natural, physical, or material world or universe. 'Nature' can refer to the phenomena of the physical world, and also to life in general. The study of nature is a large part of science. Although humans are part of nature, human activity is often understood as a separate category from other natural phenomena."
    static let ALERT_TITLE = "請問您要?"
    
    static let MODE_MAP = "地圖模式"
    
    static let INTRO = "進入介紹"
    static let LOCATION = "顯示 位置"
    static let NAVIGATION_TEXT = "進行 導航"
    static let INPUT_SEARCH_TEXT = "請輸入搜尋的相關文字"
    static let HOME_BUTTON_1 = "市府訊息"
    static let HOME_BUTTON_2 = "熱門活動"
    static let HOME_BUTTON_3 = "便民服務"
    static let HOME_BUTTON_4 = "局處導覽"
    static let HOME_BUTTON_5 = "市府設施"
    static let HOME_BUTTON_6 = "市府APP專區"
    static let CONTENT_DESCRIPTION = "contentDescription"
    static let HOT_FILTER = "活動訊息列表"
    static let HOT_ISSUS = "發布日期："
    static let HOT_DELETE = "是否隱藏此活動訊息？"
    static let HIDDEN_HOT_CLOSE = "不顯示隱藏的活動訊息"
    static let HIDDEN_HOT_OPEN = "顯示隱藏的活動訊息"
    static let ADMIN_LIST = "行政單位列表"
    static let PLEASE_WAIT = "資料讀取中，請稍候。"
    static let INSTRUCTION_WELCOME_1 = "Hi 您好：\n\r歡迎使用臺南洽公小幫手，小幫手除了將市府最新消息、熱門活動、福利資訊提供給您，只要搜尋您要去的局處或打關鍵字，即可知道您要接洽的業務相關資訊，包括業務執掌、連絡方式以及相關網站等的資料"
    static let INSTRUCTION_WELCOME_2 = "最特別的是，我們運用Beacon微定位技術，在市府大樓，進行室內導航功能，您在要去的局處上點選導航之後，會自動切換到地圖模式，導引您輕鬆到達洽公目的地。"
    static let INSTRUCTION_WELCOME_3 = "讓我們開始體驗小幫手的服務吧。"
    static let INSTRUCTION_LEFT_RIGHT_CONTENT = "左右滑動以瀏覽內容"
    static let INSTRUCTION_UP_DOWN_CONTENT = "上下滑動以瀏覽內容"
    static let INSTRUCTION_LEFT_RIGHT_FUNCTION = "左右滑動以切換功能類別"
    static let INSTRUCTION_MAP_POSITIONING = "點選\'定位\'後，會自動切換到地圖模式，顯示要去洽公的樓層及位置。"
    static let INSTRUCTION_MAP_NAVIGATING = "點選\'導航\'後，會自動切換到地圖模式，並指引使用者行走路徑。"
    static let INSTRUCTION_MAP_INFO = "按下 Info 按鈕後，就可以開關資訊欄。"
    static let NEXT_STEP = "下一步"
    static let OK_STEP = "確定"
    static let CANCEL_STEP = "取消"
    static let ALERT_TITLE_HINT = "提醒"
    static let ALERT_TITLE_WARNING = "警告"
    static let INTERNET_NOT_OPEN = "請開啟網路連線以更新資料！"
    static let MUST_OPEN_BLUETOOTH = "請開啟藍芽才能進行導航功能！"
    static let EXIT_APP = "離開台南洽公小幫手？"
    static let CLICK_OK = "按下確定以離開！"
}
