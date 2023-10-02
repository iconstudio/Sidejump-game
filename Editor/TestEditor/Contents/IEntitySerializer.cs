namespace TestEditor.Contents
{
	internal interface IEntitySerializer<out T, out S>
		where T : notnull, ISerializedEntity<S>
		where S : notnull, new()
	{
	}
}
