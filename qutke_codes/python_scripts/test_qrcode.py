# import qrcode
# img = qrcode.make('十一点了！还睡呢？🐷啊？')

# with open('/Users/chentianbo/Desktop/test.png', 'wb') as f:
#     img.save(f)



import qrcode
from PIL import Image
import matplotlib.pyplot as plt


def getQRcode(data, file_name):
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=5,
        border=4,
    )

    # 添加数据
    qr.add_data(data)
    # 填充数据
    qr.make(fit=True)
    # 生成图片
    img = qr.make_image(fill_color="green", back_color="white")

    # 添加logo，打开logo照片
    icon = Image.open("/Users/chentianbo/Desktop/WechatIMG1684.jpeg")
    # 获取图片的宽高
    img_w, img_h = img.size
    # 参数设置logo的大小
    factor = 4
    size_w = int(img_w / factor)
    size_h = int(img_h / factor)
    icon_w, icon_h = icon.size
    print(icon_w, icon_h)

    if icon_w > size_w:
        icon_w = size_w
    if icon_h > size_h:
        icon_h = size_h
    # 重新设置logo的尺寸
    icon = icon.resize((icon_w, icon_h), Image.ANTIALIAS)
    # 得到画图的x，y坐标，居中显示
    w = int((img_w - icon_w) / 2)
    h = int((img_h - icon_h) / 2)
    # 黏贴logo照
    img.paste(icon, (w, h), mask=None)
    # 终端显示图片


    # plt.imshow(img)
    # plt.show()
    # # 保存img
    # img.save(file_name) 
    return img


if __name__ == '__main__':
    getQRcode("超可爱的张五岁！", '/Users/chentianbo/Desktop/test.png')