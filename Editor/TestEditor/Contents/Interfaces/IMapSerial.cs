namespace TestEditor.Contents
{
	internal interface IMapSerial : IMapObject
	{
		bool IMapObject.IsSerializable => true;
	}
	internal interface IMapSerial<out T> : IMapObject, IMapSerial
	{
		T Deserialize();
	}
}
