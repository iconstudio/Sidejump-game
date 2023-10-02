namespace TestEditor.Contents
{
	internal interface IEntitySerializer<out T, out S>
		where T : notnull
		where S : notnull, ISerializedEntity<T>
	{
	}
}
