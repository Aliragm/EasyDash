defmodule EasyDash.IotTest do
  use EasyDash.DataCase

  alias EasyDash.Iot

  describe "leituras" do
    alias EasyDash.Iot.Leitura

    import EasyDash.IotFixtures

    @invalid_attrs %{temperatura: nil, umidade: nil, sensor_id: nil}

    test "list_leituras/0 returns all leituras" do
      leitura = leitura_fixture()
      assert Iot.list_leituras() == [leitura]
    end

    test "get_leitura!/1 returns the leitura with given id" do
      leitura = leitura_fixture()
      assert Iot.get_leitura!(leitura.id) == leitura
    end

    test "create_leitura/1 with valid data creates a leitura" do
      valid_attrs = %{temperatura: 120.5, umidade: 120.5, sensor_id: "some sensor_id"}

      assert {:ok, %Leitura{} = leitura} = Iot.create_leitura(valid_attrs)
      assert leitura.temperatura == 120.5
      assert leitura.umidade == 120.5
      assert leitura.sensor_id == "some sensor_id"
    end

    test "create_leitura/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iot.create_leitura(@invalid_attrs)
    end

    test "update_leitura/2 with valid data updates the leitura" do
      leitura = leitura_fixture()
      update_attrs = %{temperatura: 456.7, umidade: 456.7, sensor_id: "some updated sensor_id"}

      assert {:ok, %Leitura{} = leitura} = Iot.update_leitura(leitura, update_attrs)
      assert leitura.temperatura == 456.7
      assert leitura.umidade == 456.7
      assert leitura.sensor_id == "some updated sensor_id"
    end

    test "update_leitura/2 with invalid data returns error changeset" do
      leitura = leitura_fixture()
      assert {:error, %Ecto.Changeset{}} = Iot.update_leitura(leitura, @invalid_attrs)
      assert leitura == Iot.get_leitura!(leitura.id)
    end

    test "delete_leitura/1 deletes the leitura" do
      leitura = leitura_fixture()
      assert {:ok, %Leitura{}} = Iot.delete_leitura(leitura)
      assert_raise Ecto.NoResultsError, fn -> Iot.get_leitura!(leitura.id) end
    end

    test "change_leitura/1 returns a leitura changeset" do
      leitura = leitura_fixture()
      assert %Ecto.Changeset{} = Iot.change_leitura(leitura)
    end
  end
end
