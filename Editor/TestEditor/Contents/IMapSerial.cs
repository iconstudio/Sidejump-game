namespace TestEditor.Contents
{
	internal interface IMapSerial : IMapObject
	{
	}
	internal interface IMapSerial<out T> : IMapObject, IMapSerial
	{
		T Deserialize();
	}
}
