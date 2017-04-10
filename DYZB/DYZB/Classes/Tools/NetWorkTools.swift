//
//  NetWorkTools.swift
//  DYZB
//
//  Created by gujianhua on 2017/4/10.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
   case MethodTypeGet
   case MethodTypePost
}

class NetWorkTools{
    class func requestData(type : MethodType, urlString: String, parameters: [String : Any]?, finishedBlock:@escaping (_ result : Any) -> ()){
        
        let method = type == .MethodTypeGet ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            //判断response有没有值
            guard let result = response.result.value else{
                print(response.result.error ?? "获取数据出错")
                return;
            }
            
            finishedBlock(result)
        }
    }
}
