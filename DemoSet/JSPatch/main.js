
//defineClass('ViewController', {
//            
//            viewDidLoad: function() {
//            self.ORIGviewDidLoad();
//            var width = require('UIScreen').mainScreen().bounds().width
//            var btn = require('UIButton').alloc().initWithFrame({x:0, y:100, width:width, height:50})
//            btn.setTitle_forState('这个按钮是通过JSPatch动态添加上去的啊', 0)
//            btn.addTarget_action_forControlEvents(self, "handleBtn:", 1 << 6)
//            btn.setBackgroundColor(require('UIColor').blueColor())
//            self.view().addSubview(btn)
//            },
//            handleBtn: function(sender) {
//            console.log('这是动态添加的按钮响应事件')
//            },
//            })

//defineClass('ViewController', {
//            
//            buttonClick:function() {
//            self.ORIGbuttonClick();
//            
//            var myname = self.name();
//            var vc = require('JSPatchViewController').alloc().init();
//            vc.setTitle(myname);
//            self.navigationController().pushViewController_animated(vc, YES);
//            }
//            })

//defineClass('TableViewController', {
//            
//             tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
//            var cell = tableView.dequeueReusableCellWithIdentifier("ReuseID");
//            if (!cell) {
//            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "ReuseID");
//            }
//            var row = indexPath.row()
//            
//            var content = self.dataArray().objectAtIndex(row);
//            cell.textLabel().setText(content);
//            return cell;
//            }
//            })


//defineClass('DetailViewController',['textField'],{
//            setupViews:function() {
//            textField = require('UITextField').alloc().initWithFrame({x:10, y:100, width:300, height:50});
//            textField.setBorderStyle(3);
//            self.view().addSubview(textField);
//            
//            var button = require('UIButton').alloc().initWithFrame({x:10, y:200, width:300, height:50});
//            button.setBackgroundColor(require('UIColor').blueColor());
//            button.setTitle_forState("点我跳转", 0);
//            
//            button.addTarget_action_forControlEvents(self, "buttonClick:", 1 << 6);
//            self.view().addSubview(button);
//            },
//            
//            buttonClick:function(sender) {
//            
//            var text = textField.text();
//            
//            if(!text.hasPrefix("https://")) {
//            
//            var alert = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("提示","输入的网址不合法", null, "确定", "取消", null);
//            alert.show();
//            
//            return;
//            }
//            require('UIApplication').sharedApplication().openURL(require('NSURL').URLWithString(text));
//            }
//            })
//            

















