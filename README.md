# WaterFall Layout  (瀑布流布局)

![瀑布流样式](http://www.moke8.com/data/attachment/forum/201409/26/200503nnsrn42u41e5jk2i.jpg)

百度百科解释如下 :  
> 瀑布流，又称瀑布流式布局。是比较流行的一种网站页面布局，视觉表现为参差不齐的多栏布局，随着页面滚动条向下滚动，这种布局还会不断加载数据块并附加至当前尾部。最早采用此布局的网站是Pinterest，逐渐在国内流行开来。

## 利用UICollectionView实现瀑布流
* 创建自定义类继承UICollectionViewLayout
* 手动实现以下四个方法

方法 | 说明
---|---
- (void)prepareLayout | collectionView第一次布局的时候和布局失效的时候会调用该方法, 需要注意的是子类记得要调用**super**
- (NSArray<UICollectionViewLayoutAttributes \*> \*)layoutAttributesForElementsInRect:(CGRect)rect | 返回rect范围内所有元素的布局属性的数组
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath | 返回indexPath位置上的元素的布局属性
- (CGSize)collectionViewContentSize | 返回collectionView的滚动范围

### 注意 : 因为layoutAttributesForElementsInRect方法调用十分频繁, 所以布局属性的数组应该只计算一次保存起来而不是每次调用该方法的时候重新计算

* 代理

提供接口给外界修改一些瀑布流布局的参数, 例如显示的列数, 列距, 行距, 边缘距(UIEdgeInsets), 最重要的还是item的**高度**!! 因为每个图片(item)的高度是由图片的宽高比和itemWidth来共同决定的. 所以itemHeight必须由代理来决定.这里展示几个代理方法 :

代理方法 | 说明 
--- | ---
**@required** | 
- (CGFloat)waterFallLayout:(JRWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width | 返回index位置下的item的高度
**@optional** | 
- (NSUInteger)columnCountOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout | 返回瀑布流显示的列数
- (CGFloat)rowMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout | 返回行间距
- (CGFloat)columnMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout | 返回列间距
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout | 返回边缘间距

注意 : 由于上面所说的, layoutAttributesForElementsInRect方法调用十分频繁, 所以代理方法势必也会频繁调用. 但是并不是所有代理方法都是@required的, 所以在调用@optional的代理方法时需要每次都判断代理是否响应了该选择子

<pre>
if ( [self.delegate respondsToSelector:@selector(columnCountOfWaterFallLayout:)] ) {
	_columnCount = [self.delegate columnCountOfWaterFallLayout:self];
} else {
	_columnCount = JRDefaultColumnCount;
}
</pre>

每次都这样判断显然效率很低, 我们可以在prepareLayout方法中进行一次性判断, 然后用一个flags存储起来, 那么下次我们在调用的时候直接对flag进行判断即可. 如下 : 

<pre>
struct { // 记录代理是否响应选择子
        BOOL didRespondColumnCount : 1; // 这里的1是用1个字节存储
        BOOL didRespondColumnMargin : 1;
        BOOL didRespondRowMargin : 1;
        BOOL didRespondEdgeInsets : 1;
} _delegateFalgs;

- (void)setupDelegateFlags
{
    _delegateFalgs.didRespondColumnCount = [self.delegate respondsToSelector:@selector(columnCountOfWaterFallLayout:)];
    
    _delegateFalgs.didRespondColumnMargin = [self.delegate respondsToSelector:@selector(columnMarginOfWaterFallLayout:)];
    
    _delegateFalgs.didRespondRowMargin = [self.delegate respondsToSelector:@selector(rowMarginOfWaterFallLayout:)];
    
    _delegateFalgs.didRespondEdgeInsets = [self.delegate respondsToSelector:@selector(edgeInsetsOfWaterFallLayout:)];
}

// 那么下次调用方法的时候就变成下面那么优雅了
_columnCount = _delegateFalgs.didRespondColumnCount ? [self.delegate columnCountOfWaterFallLayout:self] : JRDefaultColumnCount;

</pre>


